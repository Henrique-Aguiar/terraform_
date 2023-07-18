resource "aws_api_gateway_rest_api" "enviar_emails_API" {
  name        = "enviar-emails-API"
  description = "Created by AWS Lambda"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "enviar_emails_API" {
  rest_api_id = "${aws_api_gateway_rest_api.enviar_emails_API.id}"
  parent_id   = "${aws_api_gateway_rest_api.enviar_emails_API.root_resource_id}"
  path_part   = "enviar-email"
}

resource "aws_api_gateway_method" "POST" {
  rest_api_id   = "${aws_api_gateway_rest_api.enviar_emails_API.id}"
  resource_id   = "${aws_api_gateway_resource.enviar_emails_API.id}"
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "POST" {
    rest_api_id   = "${aws_api_gateway_rest_api.enviar_emails_API.id}"
    resource_id   = "${aws_api_gateway_resource.enviar_emails_API.id}"
    http_method   = "${aws_api_gateway_method.POST.http_method}"
    status_code   = 200

    response_models = {
        "application/json" = "Empty"
    }
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = true,
        "method.response.header.Access-Control-Allow-Methods" = true,
        "method.response.header.Access-Control-Allow-Origin" = false
    }
    # depends_on = ["aws_api_gateway_method.options_method"]
}

resource "aws_api_gateway_integration" "enviar_emails_API" {
  rest_api_id = "${aws_api_gateway_rest_api.enviar_emails_API.id}"
  resource_id = "${aws_api_gateway_method.POST.resource_id}"
  http_method = "${aws_api_gateway_method.POST.http_method}"
  cache_namespace         = aws_api_gateway_resource.enviar_emails_API.id
  content_handling        = "CONVERT_TO_TEXT"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.enviar_emails.invoke_arn}"
}

resource "aws_api_gateway_integration_response" "enviar_emails_API" {
  rest_api_id = aws_api_gateway_rest_api.enviar_emails_API.id
  resource_id = aws_api_gateway_method.POST.resource_id
  http_method = aws_api_gateway_method.POST.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

resource "aws_api_gateway_deployment" "enviar_emails_API" {
  rest_api_id = "${aws_api_gateway_rest_api.enviar_emails_API.id}"
}

resource "aws_api_gateway_stage" "enviar_emails_API" {
  stage_name    = "default"
  rest_api_id   = aws_api_gateway_rest_api.enviar_emails_API.id
  deployment_id = aws_api_gateway_deployment.enviar_emails_API.id
  description           = "Created by AWS Lambda"
  lifecycle {
    ignore_changes = [ deployment_id ]
  }
}

resource "aws_api_gateway_domain_name" "api_dves_cloud" {
  regional_certificate_arn = aws_acm_certificate_validation.dves_cloud.certificate_arn
  domain_name     = "api.dves.cloud"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_apigatewayv2_api_mapping" "api_dves_cloud" {
  api_id      = aws_api_gateway_rest_api.enviar_emails_API.id
  domain_name = aws_api_gateway_domain_name.api_dves_cloud.domain_name
  stage       = aws_api_gateway_stage.enviar_emails_API.stage_name
}

# OPTIONS HTTP method.
resource "aws_api_gateway_method" "options" {
  rest_api_id      = aws_api_gateway_rest_api.enviar_emails_API.id
  resource_id      = aws_api_gateway_resource.enviar_emails_API.id
  http_method      = "OPTIONS"
  authorization    = "NONE"
  api_key_required = false
}

# OPTIONS method response.
resource "aws_api_gateway_method_response" "options" {
  rest_api_id = aws_api_gateway_rest_api.enviar_emails_API.id
  resource_id = aws_api_gateway_resource.enviar_emails_API.id
  http_method = aws_api_gateway_method.options.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false
    "method.response.header.Access-Control-Allow-Methods" = false
    "method.response.header.Access-Control-Allow-Origin"  = false
  }
}

# OPTIONS integration.
resource "aws_api_gateway_integration" "options" {
  rest_api_id          = aws_api_gateway_rest_api.enviar_emails_API.id
  resource_id          = aws_api_gateway_resource.enviar_emails_API.id
  http_method          = "OPTIONS"
  type                    = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
}

# OPTIONS integration response.
resource "aws_api_gateway_integration_response" "options" {
  rest_api_id = aws_api_gateway_rest_api.enviar_emails_API.id
  resource_id = aws_api_gateway_resource.enviar_emails_API.id
  http_method = aws_api_gateway_integration.options.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}