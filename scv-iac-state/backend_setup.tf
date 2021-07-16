
provider "aws" {
    region = var.region
}

locals {
  pet_name = random_pet.name.id
  var.tfstate_name != "" ? var.tfstate_name : "scv-seed"
  s3_bucket_name = "${var.tfstate_name}-${local.pet_name}"
}

module "terraform_state_backend_baseline" {
   source = "./modules/terraform-aws-tfstate-backend"
   # Cloud Posse recommends pinning every module to a specific version
   # version     = "x.x.x"
   namespace  = var.tfstate_namespace
   stage      = var.tfstate_stage
   name       = local.s3_bucket_name
   attributes = ["state"]

   terraform_backend_config_file_path = "."
   terraform_backend_config_file_name = "backend-${local.pet_name}.tf"
   force_destroy                      = false
 }

