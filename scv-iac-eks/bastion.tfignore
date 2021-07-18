


module "aws_key_pair" {
   source              = "./modules/terraform-aws-ec2-bastion-server"
 #   version             = "0.18.0"
   attributes          = ["ssh", "key"]
   ssh_public_key_path = var.ssh_key_path
   generate_ssh_key    = var.generate_ssh_key
   namespace  = var.eks_namespace
   stage      = var.eks_stage
   name       = var.eks_name
  
}

module "ec2_bastion" {
  source = "./modules/terraform-aws-ec2-bastion-server"

  enabled = true

  instance_type               = var.instance_type
  security_groups             = compact(concat([module.vpc.vpc_default_security_group_id], var.security_groups))
  subnets                     = data.aws_subnet_ids.public_subnet_ids.ids
   key_name                    = module.aws_key_pair.key_name
   user_data                   = var.user_data
   vpc_id                      = data.aws_vpc.baseline.id
   associate_public_ip_address = true

   namespace  = var.eks_namespace
   stage      = var.eks_stage
   name       = var.eks_name
 
}
