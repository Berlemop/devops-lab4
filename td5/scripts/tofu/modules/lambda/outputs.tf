output "function_arn" {
  value       = aws_lambda_function.function.arn
  description = "The ARN of the Lambda Function"
}

output "function_name" {
  value       = aws_lambda_function.function.function_name
  description = "The name of the Lambda Function"
}
