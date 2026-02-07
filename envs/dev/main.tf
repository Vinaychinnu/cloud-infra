module "vpc" {
  source = "../../modules/vpc"

  cidr_block = "10.0.0.0/16"
  name       = "dev-vpc"

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}