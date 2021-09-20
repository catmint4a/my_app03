terraform {
  required_version = "1.0.7"
  backend "s3" {
    bucket = "myapp04-s3-bucket"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
