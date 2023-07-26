resource "aws_cloudwatch_event_rule" "enviar_email_5min" {
  name        = "enviar-email-5min"
  description = "trigger lambda every 5 minute"
  event_bus_name = "default"
  schedule_expression = "cron(0 0 ? * * *)"
}

resource "aws_cloudwatch_event_target" "enviar_email_5min" {
  rule      = aws_cloudwatch_event_rule.enviar_email_5min.name
  target_id = "r8j5n8o03horztmuhbnf"
  arn       = aws_lambda_function.enviar_emails.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.enviar_emails.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.enviar_email_5min.arn
}