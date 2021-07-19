
region = "ap-southeast-1"

ssm_namespace = "scv"
ssm_stage = "development"
ssm_name = "zero"

parameter_write = [
  {
    name      = "/zero/environment/component/password"
    value     = "X"
    type      = "SecureString"
    overwrite = "true"
  }
]