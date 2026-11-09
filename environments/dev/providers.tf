provider "aws" {
  alias = "frankfurt"
  region = "eu-central-1"

  default_tags {
    tags = local.common_tags
  }
}

provider "aws" {
  alias = "nvirginia"
  region = "us-east-1"

  default_tags {
    tags = local.common_tags
  }
}