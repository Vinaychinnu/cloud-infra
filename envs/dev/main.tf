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
