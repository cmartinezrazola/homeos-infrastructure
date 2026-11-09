resource "aws_db_subnet_group" "this" {
  name ="${local.name_prefix}-rds-subnet-group"
  description = "DB Subnet Group"

  subnet_ids = var.rds_subnet_ids

  tags = {
    Name = "${local.name_prefix}-rds-subnet-group"
  }
}

resource "aws_security_group" "this" {
  name        = "${local.name_prefix}-rds-sg"
  description = "Security group for PostgreSQL RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow PostgreSQL traffic from application security group"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [
        var.app_security_group_id, 
    ]
  }

  egress {
    description = "Allow internal traffic within the VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = [var.vpc_cidr]
  }

  tags = {
    Name = "${local.name_prefix}-rds-sg"
  }
}