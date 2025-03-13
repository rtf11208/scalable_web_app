terraform {
  backend "s3" {
    bucket = "ronnie-scalable-website-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
