resource "aws_instance" "servidor_terraform" {
  for_each = var.servidores

  ami                    = var.ami_id
  instance_type          = var.tipo_instancia
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [aws_security_group.grupo_seguridad.id]


resource "null_resource" "ejecutar_script"
  
  provisioner "local-exec" {
    command = "python3 /home/cristian/app/requirements.txt"

  provisioner "local-exec" {
    command = "python3 /home/cristian/app/main.py"

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