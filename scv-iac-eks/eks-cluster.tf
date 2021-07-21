 
provider "aws" {
    region = var.region
}

  module "eks_label" {
    source = "./modules/terraform-null-label"
    # Cloud Posse recommends pinning every module to a specific version
    # version     = "x.x.x"
    namespace  = var.eks_namespace
    name       = var.eks_name
    stage      = var.eks_stage
    delimiter  = "-"
    # attributes = compact(concat(var.attributes, list("cluster")))
    
  }

locals {
    # The usage of the specific kubernetes.io/cluster/* resource tags below are required
    # for EKS and Kubernetes to discover and manage networking resources
    # https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html#base-vpc-networking
    tags = merge(map("kubernetes.io/cluster/${module.eks_label.id}", "shared"))

    # Unfortunately, most_recent (https://github.com/cloudposse/terraform-aws-eks-workers/blob/34a43c25624a6efb3ba5d2770a601d7cb3c0d391/main.tf#L141)
    # variable does not work as expected, if you are not going to use custom AMI you should
    # enforce usage of eks_worker_ami_name_filter variable to set the right kubernetes version for EKS workers,
    # otherwise the first version of Kubernetes supported by AWS (v1.11) for EKS workers will be used, but
    # EKS control plane will use the version specified by kubernetes_version variable.
    eks_worker_ami_name_filter = "amazon-eks-node-${var.kubernetes_version}*"

    # required tags to make ALB ingress work https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html
    public_subnets_additional_tags = {
      "kubernetes.io/role/elb" : 1
    }
    private_subnets_additional_tags = {
      "kubernetes.io/role/internal-elb" : 1
    }
  }

# Ensure ordering of resource creation to eliminate the race conditions when applying the Kubernetes Auth ConfigMap.
# Do not create Node Group before the EKS cluster is created and the `aws-auth` Kubernetes ConfigMap is applied.
# Otherwise, EKS will create the ConfigMap first and add the managed node role ARNs to it,
# and the kubernetes provider will throw an error that the ConfigMap already exists (because it can't update the map, only create it).
# If we create the ConfigMap first (to add additional roles/users/accounts), EKS will just update it by adding the managed node role ARNs.
data "null_data_source" "wait_for_cluster_and_kubernetes_configmap" {
  inputs = {
    cluster_name             = module.eks_cluster_new.eks_cluster_id
    kubernetes_config_map_id = module.eks_cluster_new.kubernetes_config_map_id
  }
}



module "eks_node_group" {
  source  = "./modules/terraform-aws-eks-node-group"

  namespace  = var.eks_namespace
  stage      = var.eks_stage
  name       = var.eks_name

  subnet_ids        = data.aws_subnet_ids.public_subnet_ids.ids
  cluster_name      = data.null_data_source.wait_for_cluster_and_kubernetes_configmap.outputs["cluster_name"]
  instance_types    = var.instance_types
  desired_size      = var.desired_size
  min_size          = var.min_size
  max_size          = var.max_size
  kubernetes_labels = var.kubernetes_labels
  disk_size         = var.disk_size

}


module "eks_cluster_new" {
  source = "./modules/terraform-aws-eks-cluster"

  namespace  = var.eks_namespace
  stage      = var.eks_stage
  name       = var.eks_name

  region     = var.region
  vpc_id     = data.aws_vpc.baseline.id
  # public subnet_ids are required for the cluster to support external ALB ingress resources.
  subnet_ids = concat(tolist(data.aws_subnet_ids.public_subnet_ids.ids), tolist(data.aws_subnet_ids.private_subnet_ids.ids))
  #subnet_ids = tolist(data.aws_subnet_ids.private_subnet_ids.ids)

  kubernetes_version           = var.kubernetes_version
  local_exec_interpreter       = var.local_exec_interpreter
  oidc_provider_enabled        = var.oidc_provider_enabled
  enabled_cluster_log_types    = var.enabled_cluster_log_types
  cluster_log_retention_period = var.cluster_log_retention_period

  cluster_encryption_config_enabled                         = var.cluster_encryption_config_enabled
  cluster_encryption_config_kms_key_id                      = var.cluster_encryption_config_kms_key_id
  cluster_encryption_config_kms_key_enable_key_rotation     = var.cluster_encryption_config_kms_key_enable_key_rotation
  cluster_encryption_config_kms_key_deletion_window_in_days = var.cluster_encryption_config_kms_key_deletion_window_in_days
  cluster_encryption_config_kms_key_policy                  = var.cluster_encryption_config_kms_key_policy
  cluster_encryption_config_resources                       = var.cluster_encryption_config_resources

}

# module "eks_workers" {
#     source = "./modules/terraform-aws-eks-workers"
#     # Cloud Posse recommends pinning every module to a specific version
#     # version     = "x.x.x"
#     namespace                          = var.eks_namespace
#     stage                              = var.eks_stage
#     name                               = var.eks_name
#     # attributes                         = var.attributes
#     # tags                               = var.tags
#     instance_type                      = var.instance_type
#     eks_worker_ami_name_filter          = local.eks_worker_ami_name_filter
#     vpc_id                             = data.aws_vpc.baseline.id
#     subnet_ids                         = data.aws_subnet_ids.public_subnet_ids.ids
#     health_check_type                  = var.health_check_type
#     min_size                           = var.min_size
#     max_size                           = var.max_size
#     wait_for_capacity_timeout          = var.wait_for_capacity_timeout
#     cluster_name                       = module.eks_label.id
#     cluster_endpoint                   = module.eks_cluster.eks_cluster_endpoint
#     cluster_certificate_authority_data = module.eks_cluster.eks_cluster_certificate_authority_data
#     # cluster_security_group_id          = module.eks_cluster.security_group_id

#     # Auto-scaling policies and CloudWatch metric alarms
#     autoscaling_policies_enabled           = var.autoscaling_policies_enabled
#     cpu_utilization_high_threshold_percent = var.cpu_utilization_high_threshold_percent
#     cpu_utilization_low_threshold_percent  = var.cpu_utilization_low_threshold_percent
#   }


  # module "eks_cluster" {
  #   source = "./modules/terraform-aws-eks-cluster"
  #   # Cloud Posse recommends pinning every module to a specific version
  #   # version     = "x.x.x"
  #   namespace  = var.eks_namespace
  #   stage      = var.eks_stage
  #   name       = var.eks_name
  #   # attributes = var.attributes
  #   # tags       = var.tags
  #   vpc_id     = data.aws_vpc.baseline.id
  #   subnet_ids = data.aws_subnet_ids.public_subnet_ids.ids
  #   region = var.region

  #   kubernetes_version    = var.kubernetes_version
  #   oidc_provider_enabled = false
  #   workers_role_arns     = [module.eks_workers.workers_role_arn]

  #   security_group_rules = [
  #     {
  #       type                     = "egress"
  #       from_port                = 0
  #       to_port                  = 65535
  #       protocol                 = "-1"
  #       cidr_blocks              = ["0.0.0.0/0"]
  #       source_security_group_id = null
  #       description              = "Allow all outbound traffic"
  #     },
  #     {
  #       type                     = "ingress"
  #       from_port                = 0
  #       to_port                  = 65535
  #       protocol                 = "-1"
  #       cidr_blocks              = []
  #       source_security_group_id = module.eks_workers.security_group_id
  #       description              = "Allow all inbound traffic from EKS workers Security Group"
  #     }
  #   ]
  # }