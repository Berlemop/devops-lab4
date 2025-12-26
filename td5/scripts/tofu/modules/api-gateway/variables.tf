variable "name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "function_arn" {
  description = "The ARN of the Lambda function to invoke"
  type        = string
}

variable "api_gateway_routes" {
  description = "The routes to create (e.g. ['GET /'])"
  type        = list(string)
  default     = ["GET /"]
}
