locals {
  name_prefix = "${var.project}-${var.environment}"

  route_tables = {
    public      = aws_route_table.public_rtb.id
    private     = aws_route_table.private_rtb.id
    private_s3  = aws_route_table.private_s3_rtb.id
  }
}