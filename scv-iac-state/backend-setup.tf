
provider "aws" {
    region = var.region
}

locals {
  s3_bucket_name = concat(var.tfstate_name, random_pet.name.id)
}

module "terraform_state_backend_baseline" {
   source = "./modules/terraform-aws-tfstate-backend"
   # Cloud Posse recommends pinning every module to a specific version
   # version     = "x.x.x"
   namespace  = var.tfstate_namespace
   stage      = var.tfstate_stage
   pet_name   = random_pet.name.id
   name       = local.s3_bucket_name
   attributes = ["state"]
   

   terraform_backend_config_file_path = "."
   terraform_backend_config_file_name = "backend.tf"
   force_destroy                      = false
 }

