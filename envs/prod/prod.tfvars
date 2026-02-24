environment_name = "prod"

vpc_cidr = "10.1.0.0/16"

public_subnets = [
  "10.1.1.0/24",
  "10.1.2.0/24"
]

private_subnets = [
  "10.1.101.0/24",
  "10.1.102.0/24"
]

azs = [
  "ap-south-1a",
  "ap-south-1b"
]