data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.py"
  output_path = "${path.module}/lambda/function.zip"
}

resource "aws_iam_role" "lambda_logging" {
  name = "centralized-logging-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.lambda_logging.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "logging_demo" {
  function_name = "centralized-logging-demo"

  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  role    = aws_iam_role.lambda_logging.arn
  handler = "index.handler"
  runtime = "python3.12"

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logging
  ]
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/centralized-logging-demo"
  retention_in_days = 7
}