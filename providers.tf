#Setting up required providers 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#Setting the region for the aws provider and providing default tags
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Owner = "Ronnie"
      Env   = "Prod"
    }
  }
}