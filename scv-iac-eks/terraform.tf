terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "ap-southeast-1"
    bucket         = "scventures-development-baseline-olea-state"
    #key            = "lab.tfstate"
    key            = "eks.tfstate"
    dynamodb_table = "scventures-development-baseline-olea-state-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"

  }
}
