resource "aws_lambda_function" "lambda_terraform" {
  filename      = "modulos/lambda/app/app.zip"
  function_name = var.nombre_lambda
  role          = aws_iam_role.rol_lambda.arn
  handler = var.lambda_handler
  runtime = var.runtime_lambda
}

resource "aws_iam_role" "lambda_rol" {
  name = "rol_${var.nombre_lambda}"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})