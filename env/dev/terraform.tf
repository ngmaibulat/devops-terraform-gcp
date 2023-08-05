terraform {

  cloud {
    organization = "example-org-e380b0"

    workspaces {
      name = "devops-terraform-gcp"
    }
  }

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "> 5.7.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "> 4.7.0"
    }

  }

  # backend "s3" {
  #   bucket = "ngm-tfstate"
  #   key    = "demos/gcp/terraform.tfstate"
  #   region = "eu-central-1"
  # }

  required_version = "> 1.5.0"
}


provider "aws" {
  region = var.aws_region
}


provider "google" {
  # credentials = file("../../key.json")
  project = var.gcp_project
  region  = var.gcp_region
}
