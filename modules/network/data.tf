data "aws_region" "this" {}

data "aws_prefix_list" "s3_pl" {
  name = "com.amazonaws.${data.aws_region.this.region}.s3"
}