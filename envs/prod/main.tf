module "vpc" {
  source = "../../modules/vpc"

  cidr_block             = var.vpc_cidr
  name                   = "${var.environment_name}-vpc"
  environment            = var.environment_name
  availability_zones     = var.azs
  public_subnet_cidrs    = var.public_subnets
  private_subnet_cidrs   = var.private_subnets
}

module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id = module.vpc.vpc_id
  name   = var.environment_name
}

module "alb" {
  source = "../../modules/alb"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.public_sg_id
  name              = "${var.environment_name}-alb"
}

module "app" {
  source = "../../modules/app"

  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security_groups.private_sg_id
  target_group_arn  = module.alb.target_group_arn
  name              = "${var.environment_name}-app"
}

module "bastion" {
  source = "../../modules/bastion"

  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_groups.public_sg_id
  name              = "${var.environment_name}-bastion"
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}