variable "user_pool_name" {
  type    = string
  default = "user_pool"
}

variable "domain" {
  type    = string
  default = "fordevelopers"
}

variable "user_pool_client_name" {
  type    = string
  default = "cognito-pool-client"
}

variable "ExternalId" {
  type    = string
  default = "424f85ba-ce42-4e67-87b8-286683222cd9"
}

variable "aws_secret_key" {
  type = string
  default = "WXQyUnpIcEQwbXg4SzY1TUVrKzhMMkJxWVl0U3RVbk5CTGtJbGVlUA=="
}

variable "aws_access_key" {
  type = string
  default = "QUtJQTRLSDNXQUk1N1JVR1RZN04="
}