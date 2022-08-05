resource "aws_cognito_user_pool" "user_pool" {
  name                       = var.user_pool_name
  auto_verified_attributes   = ["email", "phone_number"]
  sms_authentication_message = "Your username is {username} and temporary password is {####}."
  sms_verification_message   = "This is the verification message {####}."
  username_attributes        = ["email"]

  mfa_configuration = "ON"
  software_token_mfa_configuration {
    enabled = true
  }

  sms_configuration {
    external_id    = var.ExternalId
    sns_caller_arn = aws_iam_role.test.arn
    # sns_region     = "us-east1"
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 1
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
    invite_message_template {
      email_message = "Dear {username}, your verification code is {####}."
      email_subject = "Here, your verification code baby"
      sms_message   = "Your username is {username} and temporary password is {####}."
    }
  }

  device_configuration {
    challenge_required_on_new_device      = false
    device_only_remembered_on_user_prompt = false
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
    #reply_to_email_address = "email@mydomain.com"

  }

  username_configuration {
    case_sensitive = false
  }

  password_policy {
    minimum_length                   = 10
    require_lowercase                = false
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 120
  }

  user_pool_add_ons {
    advanced_security_mode = "OFF"
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_LINK"
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    name                     = "email"
    required                 = true

    # attribute_data_type      = "String"
    # developer_only_attribute = false
    # mutable                  = false
    # name                     = "phone_number"
    # required                 = true
  }

}
# user_pool_domain

resource "aws_cognito_user_pool_client" "client" {
  # clients

  generate_secret               = false
  name                          = var.user_pool_client_name
  user_pool_id                  = aws_cognito_user_pool.user_pool.id
  refresh_token_validity        = 90
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_USER_PASSWORD_AUTH"
  ]

}
resource "aws_cognito_user_pool_domain" "cognito-domain" {
  domain       = var.domain
  user_pool_id = aws_cognito_user_pool.user_pool.id
}
