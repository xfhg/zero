
provider "aws" {
    region = var.region
}

module "terraform_state_backend_baseline" {
   source = "./modules/terraform-aws-tfstate-backend"
   # Cloud Posse recommends pinning every module to a specific version
   # version     = "x.x.x"
   namespace  = var.tfstate_namespace
   stage      = var.tfstate_stage
   name       = var.tfstate_name
   attributes = ["state"]

   terraform_backend_config_file_name = "backend-iac-state.tf"

   terraform_backend_config_file_path = "."
   force_destroy                      = false

   #terraform_backend_config_file_path = ""
   #force_destroy                      = true
 
 }

