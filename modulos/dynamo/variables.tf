variable "nombre_dynamo" {
  description = "nombre base de datos"
  type        = string
}

variable "hash_key" {
  description = "Columna principal dynamo"
  type        = map(string)
}