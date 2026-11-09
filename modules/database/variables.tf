variable "project" {
  type        = string
  description = "Name of the project"
  default     = "homeos"
}

variable "environment" {
  description = "Environment"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "The value of 'environment' must be one of the following: dev, prod."
  }
}

variable "rds_subnet_ids" {
  type        = list(string)
  description = "List of subnets IDs for the DB Subnet Group"
}

variable "vpc_id" {
    type = string
    description = "VPC ID"
}

variable "app_security_group_id" {
    type = string
    description = "App Security Group"
}

variable "vpc_cidr" {
    type = string
    description = "VPC CIDR"
}

