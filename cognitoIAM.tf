resource "aws_iam_role" "test" {
  name = "role"

  assume_role_policy = jsonencode({

    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "cognito-idp.amazonaws.com"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": var.ExternalId
                }
            }
        }
    ]
})
  inline_policy {
    name = "role_policy"

    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "sns:publish"
          ],
          "Resource" : [
            "*"
          ]
        },
      ]
    })
  }
}

