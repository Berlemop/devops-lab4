resource "aws_apigatewayv2_api" "api" {
  name          = var.name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "integration" {
  api_id           = aws_apigatewayv2_api.api.id
  integration_type = "AWS_PROXY"

  integration_uri    = var.function_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "route" {
  for_each = setunion(toset(var.api_gateway_routes), [])

  api_id    = aws_apigatewayv2_api.api.id
  route_key = each.value
  target    = "integrations/${aws_apigatewayv2_integration.integration.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function_arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
