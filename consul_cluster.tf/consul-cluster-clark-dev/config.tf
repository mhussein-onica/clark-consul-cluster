provider "aws" {
  region = "us-east-1"
}

#rebote backend commented out and have local tfstate files just for easy testing

terraform {
  # backend "s3" {
  #   bucket = "clark-tf-state-bucket"
  #   key = "env:/consul.tf/terraform.tfstate"
  #   dynamodb_table = "tf-remote-state-clark-dev"
  # }
  required_version = ">= 1.0.7"
}


