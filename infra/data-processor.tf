resource "aws_iam_role" "data_processor_role" {
  name = "data-processor-${var.environment}-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "data_processor_s3_permissions" {
  name = "data-processor-s3-permissions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:ListBucket", "s3:GetObject",
        "s3:PutObject"],
        Resource = ["arn:aws:s3:::${var.artifact_bucket}", "arn:aws:s3:::${var.artifact_bucket}/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "data_processor_role_logging_permissions" {
  role       = aws_iam_role.data_processor_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "data_processor_role_s3_permissions" {
  role       = aws_iam_role.data_processor_role.id
  policy_arn = aws_iam_policy.data_processor_s3_permissions.arn
}

resource "aws_cloudwatch_log_group" "data_processor_log_group" {
  name              = "/aws/lambda/data-processor-${var.environment}"
  retention_in_days = 14
}

resource "aws_lambda_function" "data_processor" {
  function_name = "data-processor-${var.environment}"
  role          = aws_iam_role.data_processor_role.arn
  handler       = "data_processor.app.lambda_handler"
  runtime       = "python3.12"
  s3_bucket     = "data-processor-artifacts"
  s3_key        = "data-processor-${var.data_processor_version}.zip"
  memory_size   = 512
  timeout       = 30
  environment {
    variables = {
      customer = "My first customer"
    }
  }

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.data_processor_log_group.name
  }

  depends_on = [aws_cloudwatch_log_group.data_processor_log_group, aws_iam_role.data_processor_role]
}
