variable "subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group for app instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "name" {
  description = "Base name for app instances"
  type        = string
}

variable "app_port" {
  description = "Port on which the application runs"
  type        = number
  default     = 8080
}