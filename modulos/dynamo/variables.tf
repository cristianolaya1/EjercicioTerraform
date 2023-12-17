variable "nombre_dynamo" {
  description = "nombre base de datos"
  type        = string
}

variable "hash_key" {
  description = "Columna dynamo"
  type        = map(string)
}