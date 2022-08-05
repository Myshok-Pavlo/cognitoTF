provider "aws" {
  version    = "~> 4.0"
  region     = "us-east-1"
  access_key = base64decode(var.aws_access_key)
  secret_key = base64decode(var.aws_secret_key)
}