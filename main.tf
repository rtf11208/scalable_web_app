module "networking" {
  source   = "./modules/networking"
  vpc_cidr = var.vpc_cidr
}

module "security" {
  source = "./modules/security_groups"
  vpc_id = module.networking.vpc_id
}