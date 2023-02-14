terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }
}

provider "aws" {
  region                      = "eu-west-1"
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    autoscaling = "http://moto:5000"
    ec2         = "http://moto:5000"
    ecs         = "http://moto:5000"
    eks         = "http://moto:5000"
    iam         = "http://moto:5000"
    s3          = "http://moto:5000"
  }
}
