variable "region" {
  type        = string
  description = "AWS Region"
}


## network label

variable "network_namespace" {
  type        = string
  description = "network module namespace"
}

variable "network_stage" {
  type        = string
  description = "network module stage"
}

variable "network_name" {
  type        = string
  description = "network module name"
}

variable "network_vpc_cidr" {
  type        = string
  description = "VPC cidr block"
}

variable "network_availability_zones" {
  type        = list(string)
  description = "List of Availability Zones where subnets will be created"
}

