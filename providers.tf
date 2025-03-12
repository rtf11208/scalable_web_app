#Setting up required providers 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#Setting the region for the aws provider 
provider "aws" {
  region = "us-east-1"
}