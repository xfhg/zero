variable "region" {
  type        = string
  description = "AWS Region"
}


## ssm label

variable "ssm_namespace" {
  type        = string
  description = "ssm module namespace"
}

variable "ssm_stage" {
  type        = string
  description = "ssm module stage"
}

variable "ssm_name" {
  type        = string
  description = "ssm module name"
}

variable "parameter_write" {
  type        = list(map(string))
  description = "List of maps with the parameter values to write to SSM Parameter Store"
}



