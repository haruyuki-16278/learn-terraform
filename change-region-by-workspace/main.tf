terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

locals {
  target = terraform.workspace == "default" ? "dev" : terraform.workspace
  architecture = "amd64"
  release = "24.04"
}

provider "aws" {
  region = local.target == "prod" ? "ap-northeast-3" : "ap-northeast-1"
}
data "aws_ami" "ubuntu_server" {
  most_recent = true
  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-${local.release}-${local.architecture}-server-*"]
  }
}

resource "aws_instance" "ubuntu" {
  ami = data.aws_ami.ubuntu_server.id
  instance_type = "t3.micro"

  tags = {
    Name = "ubuntu-server-${local.release}-${local.architecture}-${local.target}"
  }
}
