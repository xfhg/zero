

module "rds_instance" {
  source               = "./modules/terraform-aws-rds"

  namespace  = var.rds_namespace
  name       = var.rds_name
  stage      = var.rds_stage


  database_name        = var.database_name
  database_user        = var.database_user
  database_password    = var.database_password
  database_port        = var.database_port
  multi_az             = var.multi_az
  storage_type         = var.storage_type
  allocated_storage    = var.allocated_storage
  storage_encrypted    = var.storage_encrypted
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_parameter_group   = var.db_parameter_group
  publicly_accessible  = var.publicly_accessible
  vpc_id               = data.aws_vpc.baseline.id
  subnet_ids           = data.aws_subnet_ids.private_subnet_ids.ids
  security_group_ids   = [module.rds-sg.id]
  apply_immediately    = var.apply_immediately
  availability_zone    = var.availability_zone
  db_subnet_group_name = var.db_subnet_group_name

  db_parameter = [
    {
      name         = "myisam_sort_buffer_size"
      value        = "1048576"
      apply_method = "immediate"
    },
    {
      name         = "sort_buffer_size"
      value        = "2097152"
      apply_method = "immediate"
    }
  ]

 
}


module "rds-sg" {
  source = "./modules/terraform-aws-security-group"

  vpc_id = data.aws_vpc.baseline.id

namespace  = var.sg_namespace
  name       = var.sg_name
  stage      = var.sg_stage
  rules = [
    {
      type        = "ingress"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [data.aws_vpc.baseline.cidr_block]
      self        = null
      description = "Allow Access from VPC"
    },
    {
      type        = "egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "all"
      cidr_blocks = [data.aws_vpc.baseline.cidr_block]
      self        = null
      description = "Allow egress to VPC"
    }
  ]

 
}