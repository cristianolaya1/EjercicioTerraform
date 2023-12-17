resource "aws_instance" "servidor_terraform" {
  for_each = var.servidores

  ami                    = var.ami_id
  instance_type          = var.tipo_instancia
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [aws_security_group.grupo_seguridad.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Prueba funcionamiento, soy ${each.value.nombre}" > index.html
              nohup busybox httpd -f -p ${var.puerto_servidor} &
              EOF

  tags = {
    Name = each.value.nombre
  }
}

resource "aws_security_group" "grupo_seguridad" {
  name = "sg"

  ingress {
    description = "Acceso al puerto del servidor desde el LB"
    from_port   = var.puerto_servidor
    to_port     = var.puerto_servidor
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}