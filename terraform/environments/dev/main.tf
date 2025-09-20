terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "innovatemart-terraform-state-debbym889" 
    key            = "dev/terraform.tfstate"         # path inside the bucket to store state
    region         = "eu-west-1"
    dynamodb_table = "innovatemart-terraform-locks-debbym889" # for state locking
    encrypt        = true
  }

}

provider "aws" {
  region = "eu-west-1"
}
