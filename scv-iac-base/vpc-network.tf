
locals {

  # required tags to make ALB ingress work https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html
  public_subnets_additional_tags = {
    "kubernetes.io/role/elb" : 1
  }
  private_subnets_additional_tags = {
    "kubernetes.io/role/internal-elb" : 1
  }
}



  module "network_label" {
    source = "./modules/terraform-null-label"
    # Cloud Posse recommends pinning every module to a specific version
    # version     = "x.x.x"
    namespace  = var.network_namespace
    name       = var.network_name
    stage      = var.network_stage
    delimiter  = "-"
    
  }

  module "vpc" {
    source = "./modules/terraform-aws-vpc"
    namespace  = module.network_label.namespace
    stage      = module.network_label.stage
    name       = module.network_label.name
    cidr_block = var.network_vpc_cidr
  
  }

  module "subnets" {
    source = "./modules/terraform-aws-dynamic-subnets"
    availability_zones   = var.network_availability_zones
    namespace            = module.network_label.namespace
    stage                = module.network_label.stage
    name                 = module.network_label.name
    # attributes           = var.attributes
    vpc_id               = module.vpc.vpc_id
    igw_id               = module.vpc.igw_id
    cidr_block           = module.vpc.vpc_cidr_block
    nat_gateway_enabled  = true
    nat_instance_enabled = false
    public_subnets_additional_tags  = local.public_subnets_additional_tags
    private_subnets_additional_tags = local.private_subnets_additional_tags
    
    tags = merge(map("kubernetes.io/cluster/${module.network_label.id}", "shared"))
  }

