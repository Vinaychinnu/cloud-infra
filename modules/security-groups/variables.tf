variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "name" {
  description = "Base name for security groups"
  type        = string
}