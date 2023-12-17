variable "puerto_servidor" {
  description = "Puerto"
  type        = number
  default     = 8080

  validation {
    condition     = var.puerto_servidor > 0 && var.puerto_servidor <= 65536
    error_message = "Puerto fuera del rango 1-65536."
  }
}

variable "ami_id" {
  description = "AMI"
  type        = string
}

variable "tipo_instancia" {
  description = "Tipo de instancia"
  type        = string
  default     = "t2.micro"
}

variable "servidores" {
  description = "Guia servidores"

  type = map(object({
    nombre    = string,
    subnet_id = string
    })
  )
}