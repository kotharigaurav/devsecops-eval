terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "devsecops-tfstate-bucket"
    key     = "terraform/state/eks/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
