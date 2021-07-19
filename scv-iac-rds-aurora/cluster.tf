
## COMPLETE

# module "rds_cluster" {
#   source = "../../"

#   engine              = var.engine
#   engine_mode         = var.engine_mode
#   cluster_family      = var.cluster_family
#   cluster_size        = var.cluster_size
#   admin_user          = var.admin_user
#   admin_password      = var.admin_password
#   db_name             = var.db_name
#   instance_type       = var.instance_type
#   vpc_id              = module.vpc.vpc_id
#   subnets             = module.subnets.private_subnet_ids
#   security_groups     = [module.vpc.vpc_default_security_group_id]
#   deletion_protection = var.deletion_protection
#   autoscaling_enabled = var.autoscaling_enabled

#   cluster_parameters = [
#     {
#       name         = "character_set_client"
#       value        = "utf8"
#       apply_method = "pending-reboot"
#     },
#     {
#       name         = "character_set_connection"
#       value        = "utf8"
#       apply_method = "pending-reboot"
#     },
#     {
#       name         = "character_set_database"
#       value        = "utf8"
#       apply_method = "pending-reboot"
#     },
#     {
#       name         = "character_set_results"
#       value        = "utf8"
#       apply_method = "pending-reboot"
#     },
#     {
#       name         = "character_set_server"
#       value        = "utf8"
#       apply_method = "pending-reboot"
#     },
#     {
#       name         = "collation_connection"
#       value        = "utf8_bin"
#       apply_method = "pending-reboot"
#     },
#     {
#       name         = "collation_server"
#       value        = "utf8_bin"
#       apply_method = "pending-reboot"
#     },
#     {
#       name         = "lower_case_table_names"
#       value        = "1"
#       apply_method = "pending-reboot"
#     },
#     {
#       name         = "skip-character-set-client-handshake"
#       value        = "1"
#       apply_method = "pending-reboot"
#     }
#   ]

#   context = module.this.context
# }


## SIMPLE


module "rds_cluster_aurora_postgres" {

  source          = "./modules/terraform-aws-rds-cluster"
  
  namespace  = var.rds_namespace
  name       = var.rds_name
  stage      = var.rds_stage
  delimiter  = "-"
  
  engine          = "aurora-postgresql"
  cluster_family  = "aurora-postgresql11"
  cluster_size    = 2

  admin_user      = "admin1"
  admin_password  = "Test123456789"
  db_name         = "dbname"
  db_port         = 5432
  instance_type   = "db.r4.large"
  vpc_id          = data.aws_vpc.baseline.id
  security_groups = [module.aurora-sg.id]
  subnets         = data.aws_subnet_ids.private_subnet_ids.ids
  
}


module "aurora-sg" {
  source = "./modules/terraform-aws-security-group"

  vpc_id = data.aws_vpc.baseline.id

namespace  = var.sg_namespace
  name       = var.sg_name
  stage      = var.sg_stage
  rules = [
    {
      type        = "ingress"
      from_port   = 5432
      to_port     = 5432
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