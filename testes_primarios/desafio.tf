provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "desafio"{
	ami		          = "ami-0d2c30b55e0e66e1c"
	instance_type	  = "t2.micro"
  security_groups = ["desafio_diogo"]
  private_key_pem = ["chave_acesso"]

  tags = {
    Name = "lionTerraform"
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

  tags = {
    Name = "desafio_terraform"
  }

}

resource "tls_private_key" "chave_acesso" {
  algorithm   = "ECDSA"
  private_key_pem = ["${chomp(data.tls_public_key.chave.body)}"]
}