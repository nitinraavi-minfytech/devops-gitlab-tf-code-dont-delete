data "aws_availability_zones" "zones" {
  state = "available"

  filter {
    name   = "zone-name"
    values = var.availability_zones
  }
}

data "aws_ssm_parameter" "db_password" {
  name = var.db_password
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

locals {
  ami_id = data.aws_ami.ubuntu_ami.id
}
