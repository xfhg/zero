
output "eks_cluster_security_group_id" {
  description = "ID of the EKS cluster Security Group"
  value       = module.eks_cluster_new.security_group_id
}

output "eks_cluster_security_group_arn" {
  description = "ARN of the EKS cluster Security Group"
  value       = module.eks_cluster_new.security_group_arn
}

output "eks_cluster_security_group_name" {
  description = "Name of the EKS cluster Security Group"
  value       = module.eks_cluster_new.security_group_name
}

output "eks_cluster_id" {
  description = "The name of the cluster"
  value       = module.eks_cluster_new.eks_cluster_id
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks_cluster_new.eks_cluster_arn
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the Kubernetes API server"
  value       = module.eks_cluster_new.eks_cluster_endpoint
}

output "eks_cluster_version" {
  description = "The Kubernetes server version of the cluster"
  value       = module.eks_cluster_new.eks_cluster_version
}

output "eks_cluster_identity_oidc_issuer" {
  description = "The OIDC Identity issuer for the cluster"
  value       = module.eks_cluster_new.eks_cluster_identity_oidc_issuer
}

output "eks_cluster_managed_security_group_id" {
  description = "Security Group ID that was created by EKS for the cluster. EKS creates a Security Group and applies it to ENI that is attached to EKS Control Plane master nodes and to any managed workloads"
  value       = module.eks_cluster_new.eks_cluster_managed_security_group_id
}

output "eks_node_group_role_arn" {
  description = "ARN of the worker nodes IAM role"
  value       = module.eks_node_group.eks_node_group_role_arn
}

output "eks_node_group_role_name" {
  description = "Name of the worker nodes IAM role"
  value       = module.eks_node_group.eks_node_group_role_name
}

output "eks_node_group_id" {
  description = "EKS Cluster name and EKS Node Group name separated by a colon"
  value       = module.eks_node_group.eks_node_group_id
}

output "eks_node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group"
  value       = module.eks_node_group.eks_node_group_arn
}

output "eks_node_group_resources" {
  description = "List of objects containing information about underlying resources of the EKS Node Group"
  value       = module.eks_node_group.eks_node_group_resources
}

output "eks_node_group_status" {
  description = "Status of the EKS Node Group"
  value       = module.eks_node_group.eks_node_group_status
}


# output "efs_arn" {
#   value       = module.efs.arn
#   description = "EFS ARN"
# }

# output "efs_id" {
#   value       = module.efs.id
#   description = "EFS ID"
# }

# output "efs_host" {
#   value       = module.efs.host
#   description = "Route53 DNS hostname for the EFS"
# }

# output "efs_dns_name" {
#   value       = module.efs.dns_name
#   description = "EFS DNS name"
# }

# output "efs_mount_target_dns_names" {
#   value       = module.efs.mount_target_dns_names
#   description = "List of EFS mount target DNS names"
# }

# output "efs_mount_target_ids" {
#   value       = module.efs.mount_target_ids
#   description = "List of EFS mount target IDs (one per Availability Zone)"
# }

# output "efs_mount_target_ips" {
#   value       = module.efs.mount_target_ips
#   description = "List of EFS mount target IPs (one per Availability Zone)"
# }

# output "efs_network_interface_ids" {
#   value       = module.efs.network_interface_ids
#   description = "List of mount target network interface IDs"
# }

# output "security_group_id" {
#   value       = module.efs.security_group_id
#   description = "EFS Security Group ID"
# }

# output "security_group_arn" {
#   value       = module.efs.security_group_arn
#   description = "EFS Security Group ARN"
# }

# output "security_group_name" {
#   value       = module.efs.security_group_name
#   description = "EFS Security Group name"
# }






# output "instance_id" {
#   value       = module.ec2_bastion.instance_id
#   description = "Instance ID"
# }

# output "security_group_ids" {
#   value       = module.ec2_bastion.security_group_ids
#   description = "Security group IDs"
# }

# output "role" {
#   value       = module.ec2_bastion.role
#   description = "Name of AWS IAM Role associated with the instance"
# }

# output "public_ip" {
#   value       = module.ec2_bastion.public_ip
#   description = "Public IP of the instance (or EIP)"
# }

# output "private_ip" {
#   value       = module.ec2_bastion.private_ip
#   description = "Private IP of the instance"
# }

# output "private_dns" {
#   description = "Private DNS of instance"
#   value       = module.ec2_bastion.private_dns
# }

# output "public_dns" {
#   description = "Public DNS of instance (or DNS of EIP)"
#   value       = module.ec2_bastion.public_dns
# }

# output "id" {
#   description = "Disambiguated ID of the instance"
#   value       = module.ec2_bastion.id
# }