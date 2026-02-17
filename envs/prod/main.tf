module "vpc" {
  source = "../../modules/vpc"

  cidr_block = "10.1.0.0/16"
  name       = "prod-vpc"
  environment = "prod"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.1.1.0/24",
    "10.1.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.1.101.0/24",
    "10.1.102.0/24"
  ]
}

module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id = module.vpc.vpc_id
  name   = "prod"
}

module "bastion" {
  source = "../../modules/bastion"

  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_groups.public_sg_id
  name              = "prod-bastion"
}

module "app" {
  source = "../../modules/app"

  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security_groups.private_sg_id
  target_group_arn  = module.alb.target_group_arn
  name              = "prod-app"
}

module "alb" {
  source = "../../modules/alb"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_id  = module.security_groups.public_sg_id
  name               = "prod-alb"
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}