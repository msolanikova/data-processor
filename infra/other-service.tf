resource "aws_iam_role" "other_service_role" {
  name = "other-service-${var.environment}-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "other_service_s3_permissions" {
  name = "other-service-s3-permissions"

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

resource "aws_iam_role_policy_attachment" "other_service_role_logging_permissions" {
  role       = aws_iam_role.other_service_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "other_service_role_s3_permissions" {
  role       = aws_iam_role.other_service_role.id
  policy_arn = aws_iam_policy.other_service_s3_permissions.arn
}

resource "aws_cloudwatch_log_group" "other_service_log_group" {
  name              = "/aws/lambda/other-service-${var.environment}"
  retention_in_days = 14
}

resource "aws_lambda_function" "other_service" {
  function_name = "other-service-${var.environment}"
  role          = aws_iam_role.other_service_role.arn
  handler       = "data_processor.app.lambda_handler"
  runtime       = "python3.12"
  s3_bucket     = "data-processor-artifacts"
  s3_key        = "other-service-${var.other_service_version}.zip"
  memory_size   = 512
  timeout       = 30
  environment {
    variables = {
      customer = "My first customer"
    }
  }

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.other_service_log_group.name
  }

  depends_on = [aws_cloudwatch_log_group.other_service_log_group, aws_iam_role.other_service_role]
}
