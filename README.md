# terraform-aws-infra

Terraform configuration for AWS infrastructure.

Provisions a VPC with public and private subnets, an Application Load Balancer
fronting an Auto Scaling Group, and a bastion host. Separate configurations
exist for dev and prod environments.