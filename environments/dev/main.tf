module "network" {
  source = "../../modules/network"

  project     = var.project
  environment = var.environment
  vpc_cidr    = var.vpc_cidr

  subnets = var.subnets

}

module "database" {
  source = "../../modules/database"

  project     = var.project 
  environment = var.environment

  rds_subnet_ids = [
  for key, subnet in module.network.subnets : subnet.id
  if contains(["data_az1", "data_az2"], key)
  ]
  vpc_id = module.network.vpc_id
  vpc_cidr = module.network.vpc_cidr
  app_security_group_id = var.app_security_group_id # No. sera un output de serverless-backend
}