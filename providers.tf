terraform {

  # cloud {
  #   organization = "pratiksinha-org"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "random" {
  # Configuration options
}