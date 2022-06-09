provider "aws" {
  region = "us-east-1"
}

terraform {
  # backend "s3" {
  #   bucket = "clark-tf-state-bucket"
  #   key = "env:/consul-with-encrypthion.tf/terraform.tfstate"
  #   dynamodb_table = "tf-remote-state-clark-dev"
  # }
  required_version = ">= 0.12.26"
}
