
# module "kms_key" {
#   source  = "./modules/terraform-aws-key-pair"
# #   version = "0.9.0"

#   description             = "KeyPair KMS key"
#   deletion_window_in_days = 7
#   enable_key_rotation     = true

# }

# module "ssm_tls_ssh_key_pair" {
#   source               = "./modules/terraform-aws-ssm-tls-ssh-key-pair"

#   namespace  = var.key_namespace
#   stage      = var.key_stage
#   name       = var.key_name

#   kms_key_id           = module.kms_key.key_id

#   ssm_path_prefix      = var.ssm_path_prefix
#   ssh_key_algorithm    = var.ssh_key_algorithm
#   ssh_private_key_name = var.ssh_private_key_name
#   ssh_public_key_name  = var.ssh_public_key_name

# }