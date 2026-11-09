# VPC

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    route_table_key         = string
  }))
}

# RDS

variable "app_security_group_id" {
    type = string
    description = "App Security Group"
}
