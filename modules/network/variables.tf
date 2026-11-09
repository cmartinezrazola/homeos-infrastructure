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

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  description = "Map of subnets"
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = optional(bool, false)
    route_table_key         = string
  }))
  validation {
    condition = alltrue([
      for subnet in var.subnets : contains(["public", "private", "private_s3"], subnet.route_table_key)
    ])
    error_message = "The route_table_key must be one of: 'public', 'private', or 'private_s3'."
  }
}
