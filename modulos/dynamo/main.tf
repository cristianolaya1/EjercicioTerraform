resource "aws_dynamodb_table" "dynamo_terraform" {
  name           = "var.nombre_dynamo"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash_key.name

  attribute {
    name = var.hash_key.name
    type = var.hash_key.type
  }
}