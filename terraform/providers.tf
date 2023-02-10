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
    autoscaling = "http://localhost:8888"
    ec2         = "http://localhost:8888"
    ecs         = "http://localhost:8888"
    eks         = "http://localhost:8888"
    iam         = "http://localhost:8888"
    s3          = "http://localhost:8888"
  }
}
