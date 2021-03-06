terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "ap-southeast-1"
    bucket         = "scventures-development-lab-state"
    key            = "ssm.tfstate"
    dynamodb_table = "scventures-development-lab-state-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}

