terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = " "
  access_key = ""
  secret_key = " "
  profile    = "Noble"
}

