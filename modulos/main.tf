provider "aws" {
  region = local.region
}

locals {
  region          = "eu-west-3"
  nombre-ec2 = "servidor_terraform"
  nombre_bucket = "bucket_terraform"
  nombre_dynamodb = "dynamo_terraform"
  columna_dynamo = { name="ID", type="N" }
  puerto_servidor = "8080"
  runtime_lambda = "python3.11"
  funcion  = "app.zip"
  permisos_lambda     = ["AmazonDynamoDBFullAccess", "AmazonS3ReadOnlyAccess"]
  handler_nombre = "function.lambda_handler"
}


module "dynamo" {
  source        = "./modulos/dynamo"
  nombre-dynamo = local.nombre-dynamo
  hash-key      = local.columna-principal-dynamo
}

module "lambda" {
  source         = "./modulos/lambda"
  nombre_lambda  = local.nombre_lambda
  permisos       = [ for permiso in data.aws_iam_policy.permisos : permiso.arn ]
  lambda_handler = local.handler_nombre
  runtime_lambda = local.runtime_lambda
  funcion  = local.codigo_lambda
}

data "aws_iam_policy" "permisos" {
  count = length(local.permisos_lambda)
  name = local.permisos_lambda[count.index]
}

resource "aws_lambda_permission" "permitir_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.arn_lambda
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3.info_bucket.arn
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket                = module.s3.info_bucket.id

  lambda_function {
    lambda_function_arn = module.lambda.arn_lambda
    events              = ["s3:ObjectCreated:*.json"]
  }
}

module "s3" {
  source        = "./modulos/s3"
  nombre-bucket = local.nombre-bucket
}

