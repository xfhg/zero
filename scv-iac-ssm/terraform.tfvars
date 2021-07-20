
region = "ap-southeast-1"

ssm_namespace = "scv"
ssm_stage = "development"
ssm_name = "lab"

parameter_write = [
  {
    name      = "/lab/environment/component/password"
    value     = "JUST-PLACEHOLDER-DONT-WRITE-SECRETS-IN-INFRACODE"
    type      = "SecureString"
    overwrite = "true"
  }
]