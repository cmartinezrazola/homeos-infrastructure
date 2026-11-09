# Virtual Private Network

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${local.name_prefix}-vpc"
  }
}

# Subnets

resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = "${local.name_prefix}-${each.key}-subnet"
  }
}

# Route tables

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${local.name_prefix}-public-rtb"
  }
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${local.name_prefix}-private-rtb"
  }
}

resource "aws_route_table" "private_s3_rtb" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${local.name_prefix}-private-s3-rtb"
  }
}

# Route table association

resource "aws_route_table_association" "this" {
  for_each = var.subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = local.route_tables[each.value.route_table_key]
}

# Routes

resource "aws_route" "internet_rt" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route" "s3_rt" {
  route_table_id             = aws_route_table.private_s3_rtb.id
  destination_prefix_list_id = data.aws_prefix_list.s3_pl.id
  vpc_endpoint_id            = aws_vpc_endpoint.s3_vpce.id
}

# Internet gateway and endpoints

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${local.name_prefix}-igw"
  }
}

resource "aws_vpc_endpoint" "s3_vpce" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.current.region}.s3"
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "${local.name_prefix}-s3-vpce"
  }
}



