


module "efs" {
  source = "./modules/terraform-aws-efs"

  namespace  = var.eks_namespace
    stage      = var.eks_stage
     name       = "efs"

  region  = var.region
  vpc_id     = data.aws_vpc.baseline.id
  subnets = data.aws_subnet_ids.private_subnet_ids.ids
  security_group_rules = [
    {
      type                     = "egress"
      from_port                = 0
      to_port                  = 65535
      protocol                 = "-1"
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
      description              = "Allow all egress trafic"
    },
    {
      type                     = "ingress"
      from_port                = 2049
      to_port                  = 2049
      protocol                 = "tcp"
      cidr_blocks              = [data.aws_vpc.baseline.cidr_block]
      source_security_group_id = null
      description              = "Allow ingress traffic to EFS from VPC"
    }
  ]

}