terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
  profile = "default"
}

# Create EC2 instance
#resource "aws_instance" "app_server" {
#  ami           = "ami-03c1fac8dd915ff60"
#  instance_type = "t2.micro"
#
#  tags = {
#    Name = var.instance_name
#  }
#}


# Create Cognito User Pool
resource "aws_cognito_user_pool" "user_pool" {
  name = "user-pool"

  username_attributes = ["email"]
  auto_verified_attributes = ["email"]
  password_policy {
    minimum_length = 6
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject = "Account Confirmation"
    email_message = "Your confirmation code is {####}"
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }
}

# Create Cognito User Pool Client
resource "aws_cognito_user_pool_client" "user_pool_client" {
  name = "user-pool-client"

  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = false
  refresh_token_validity = 90
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
}

# Create Cognito User Pool Domain
resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain       = "rxrdsoft"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

# Store Cognito User Pool Client ID and Secret in SSM Parameter Store
resource "aws_ssm_parameter" "user_pool_client_id" {
  name  = "/user-pool-client-id"
  type  = "String"
  value = aws_cognito_user_pool_client.user_pool_client.id
}

# Store Cognito User Pool Client ID and Secret in SSM Parameter Store
resource "aws_ssm_parameter" "user_pool_id" {
  name  = "/user-pool-id"
  type  = "String"
  value = aws_cognito_user_pool.user_pool.id
}
