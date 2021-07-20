


## IMPORT EXISTING

module "aws_key_pair_import" {
  source = "./modules/terraform-aws-key-pair"


  namespace  = var.key_namespace
  stage      = var.key_stage
  name       = var.key_name

  ssh_public_key_path = var.ssh_public_key_path
  ssh_public_key_file = var.ssh_public_key_file
  generate_ssh_key    = var.generate_ssh_key

  
}

output "key_name" {
  value       = module.aws_key_pair_import.key_name
  description = "Name of SSH key"
}

output "public_key" {
  value       = module.aws_key_pair_import.public_key
  description = "Content of the imported public key"
}

output "public_key_filename" {
  description = "Public Key Filename"
  value       = module.aws_key_pair_import.public_key_filename
}

output "private_key_filename" {
  description = "Private Key Filename"
  value       = module.aws_key_pair_import.private_key_filename
}
