terraform {

  cloud {
    organization = "TeraSky"

    workspaces {
      name = "rds-blue-green-deployment"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }

  }
  required_version = ">= 1.1.0"
}
provider "aws" {
    region = "eu-west-1"
}