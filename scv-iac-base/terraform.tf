terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    key            = "baseline.tfstate"
    
    region         = "us-east-1"
    bucket         = "scventures-development-baseline-state"
    dynamodb_table = "scventures-development-baseline-state-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}

 
provider "aws" {
    region = var.region
}
 