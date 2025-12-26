resource "aws_lambda_function" "function" {
  function_name = var.name
  handler       = var.handler
  runtime       = var.runtime
  role          = aws_iam_role.role.arn
  memory_size   = var.memory_size
  timeout       = var.timeout

  # For simplicity in this lab, we'll assume the zip file is already created or just use a dummy one for now if needed.
  # However, typically you'd use archive_file or expect the user to provide the zip.
  # Given the 'src_dir' input, let's zip it.
  filename         = data.archive_file.src.output_path
  source_code_hash = data.archive_file.src.output_base64sha256

  environment {
    variables = var.environment_variables
  }
}

data "archive_file" "src" {
  type        = "zip"
  source_dir  = var.src_dir
  output_path = "${path.module}/${var.name}.zip"
}

resource "aws_iam_role" "role" {
  name = "${var.name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
