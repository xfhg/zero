terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "ap-southeast-1"
    bucket         = "scventures-development-baseline-relaxed-troll-state"
    key            = "terraform.tfstate"
    dynamodb_table = "scventures-development-baseline-relaxed-troll-state-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}
