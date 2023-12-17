provider "aws" {
  region = local.region
}

locals {
  region          = "eu-west-3"
  nombre_bucket = "bucket_terraform"
  nombre_dynamodb = "dynamo_terraform"
  columna_dynamo = { name="ID", type="N" }
}


module "dynamo" {
  source        = "./modulos/dynamo"
  nombre-dynamo = local.nombre-dynamo
  hash-key      = local.columna-principal-dynamo
}

module "s3" {
  source        = "./modulos/s3"
  nombre-bucket = local.nombre-bucket
}