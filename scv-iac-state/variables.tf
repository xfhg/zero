variable "region" {
  type        = string
  description = "AWS Region"
}

## tfstate backend conflabelig

variable "tfstate_namespace" {
  type        = string
  description = "tfstate module namespace"
}

variable "tfstate_stage" {
  type        = string
  description = "tfstate module stage"
}

variable "tfstate_name" {
  type        = string
  description = "tfstate module name"
}

variable "pet_name" {
  type        = string
}

variable "s3_parent_bucket" {
  type        = bool
  description = "set this to true for the S3 TF-State backend jobs"
  default     = false
}
