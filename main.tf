terraform {
  cloud {
    organization = "TeraSky"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "aws" {
    region = "eu-west-1"
  
}