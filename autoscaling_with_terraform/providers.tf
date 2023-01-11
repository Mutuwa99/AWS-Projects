terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "af-south-1"
  access_key = "AKIA436U47JYPYVZLJGV"
  secret_key = "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"
  profile    = "Noble"
}

