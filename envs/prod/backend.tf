terraform {
  backend "s3" {
    bucket         = "cloud-infra-tf-state-dev"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "cloud-infra-tf-locks"
    encrypt        = true
  }
}