provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "main" {
  ami             = var.instanceAmi
  instance_type   = var.instanceType
  security_groups = ["desafio_diogo"]
  key_name        = "liondelta"
  user_data       = file("user-data.sh")

  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "desafio_diogo" {
  name        = "desafio_diogo"
  description = "Security group criado para testar terraform"
  vpc_id      = "vpc-7c25ba06" #default vpc delta

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"] #para pegar o endereço local da máquina que será rodado e liberá acesso
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "desafio_terraform"
  }
}
