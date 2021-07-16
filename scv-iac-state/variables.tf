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

