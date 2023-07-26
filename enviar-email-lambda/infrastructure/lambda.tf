data "archive_file" "enviar_emails" {
  output_path = "files/enviar-email.zip"
  type = "zip"
  source_dir = "../backend"
}

resource "aws_lambda_function" "enviar_emails" {
  function_name = "enviar-emails"
  role          = aws_iam_role.enviar_emails_role.arn
  handler       = "index.handler"
  filename      = data.archive_file.enviar_emails.output_path
  source_code_hash = data.archive_file.enviar_emails.output_base64sha256
  runtime = "nodejs18.x"

  environment {
         variables = {
             "EMAIL_DESTINATION" = jsonencode(
                    [
                     "hrikelr@hotmail.com",
                     "delsantos.miranda@gmail.com",
                    ]
                ) 
             "SMTP_HOST"         = "smtp.office365.com" 
             "SMTP_PASSWORD"     = local.SMTP_PASSWORD 
             "SMTP_PORT"         = "587" 
             "SMTP_USER"         = local.SMTP_USER 
            }
        }

}

resource "aws_lambda_permission" "enviar_emails" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.enviar_emails.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.enviar_emails_API.execution_arn}/*/POST/enviar-email"
}

