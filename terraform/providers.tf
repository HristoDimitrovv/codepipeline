terraform {
  required_version = ">= 1.4.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.25.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
  }

  #   ### Backend config got tfstate file to be send to S3 ###
  #   backend "s3" {
  #     bucket = "hrdimibucket2222"
  #     key    = "cicd-terraform.tfstate"
  #     region = "eu-west-1"
  #   }

}