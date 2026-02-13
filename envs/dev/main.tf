module "vpc" {
  source = "../../modules/vpc"

  cidr_block = "10.0.0.0/16"
  name       = "dev-vpc"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
}

module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id = module.vpc.vpc_id
  name   = "dev"
}

module "bastion" {
  source = "../../modules/bastion"

  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_groups.public_sg_id
  name              = "dev-bastion"
}

module "app" {
  source = "../../modules/app"

  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security_groups.private_sg_id
  name              = "dev-app"
}

module "alb" {
  source = "../../modules/alb"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_id  = module.security_groups.public_sg_id
  app_instance_ids   = module.app.instance_ids
  name               = "dev-alb"
}