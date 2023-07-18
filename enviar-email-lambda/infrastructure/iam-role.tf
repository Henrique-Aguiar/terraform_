resource "aws_iam_role" "enviar_emails_role" {
  name = "enviar-emails-role-mu4rrjlm"
  path = "/service-role/"

  assume_role_policy = file("policies/enviar-emails-assume-role.json")

inline_policy {
         name   = "basic-lambda-role"
         policy = jsonencode(
                {
                 Statement = [
                     {
                         Action   = "lambda:GetAccountSettings"
                         Effect   = "Allow"
                         Resource = "*"
                         Sid      = "VisualEditor0"
                        },
                    ]
                 Version   = "2012-10-17"
                }
            )
        }

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy" "enviar_emails_role" {
  name = "AWSLambdaBasicExecutionRole-fde8933b-3c2f-4bb4-98af-1199050fe0c9"
  policy = file("policies/enviar-emails-role-policy.json")
  path = "/service-role/"
}

resource "aws_iam_policy_attachment" "enviar_emails_role" {
  name = "enviar-emails-role-mu4rrjlm"
  policy_arn = aws_iam_policy.enviar_emails_role.arn
  roles = [ aws_iam_role.enviar_emails_role.name ]
}