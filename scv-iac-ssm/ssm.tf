
module "kms_key" {
  source                  = "./modules/terraform-aws-kms-key"

  description             = "SSM KMS key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  alias                   = join("",["alias/",var.ssm_name])

  namespace  = var.ssm_namespace
  name       = var.ssm_name
  stage      = var.ssm_stage
  delimiter  = "-"
}

module "store" {
  source          = "./modules/terraform-aws-ssm-parameter-store"
  parameter_write = var.parameter_write
  kms_arn         = module.kms_key.key_arn

  namespace  = var.ssm_namespace
  name       = var.ssm_name
  stage      = var.ssm_stage
  delimiter  = "-"

}


## example read

# module "store_read" {
#   source          = "./modules/terraform-aws-ssm-parameter-store"
#   parameter_read = ["/zero/environment/component/password"]
# }