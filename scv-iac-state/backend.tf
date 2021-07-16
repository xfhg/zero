terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "us-east-1"
    bucket         = "scventures-development-baseline-state"
    key            = "terraform.tfstate"
    dynamodb_table = "scventures-development-baseline-state-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}
