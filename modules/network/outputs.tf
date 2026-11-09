# VPC outputs

output "vpc_id" {
  description = "ID of the primary VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR block of the primary VPC"
  value       = aws_vpc.this.cidr_block
}

# Subnet outputs

output "subnets" {
  description = "Map of all subnet objects containing their full attributes"
  value       = aws_subnet.this
}

# Route table outputs

output "public_rtb_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public_rtb.id
}

output "private_rtb_id" {
  description = "ID of the private application route table"
  value       = aws_route_table.private_rtb.id
}

output "private_s3_rtb_id" {
  description = "ID of the private data route table with S3 endpoint"
  value       = aws_route_table.private_s3_rtb.id
}