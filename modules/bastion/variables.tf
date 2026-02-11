variable "subnet_id" {
  description = "Public subnet ID for bastion host"
  type        = string
}

variable "security_group_id" {
  description = "Security group for bastion"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "name" {
  description = "Name tag for bastion"
  type        = string
}