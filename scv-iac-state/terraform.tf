terraform {
  backend "s3" {
    key = "terraform.tfstate"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

}
