terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.12.31"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

resource "aws_key_pair" "dev_ops_pub_key" {
  key_name   = "dev_ops_pub_key"
  public_key = file("/home/statys/.ssh/id_rsa.pub")
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs                = var.vpc_azs
  public_subnets     = var.public_subnet
  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.dev_ops_tags
}

data "aws_vpcs" "vpc_info" {
  tags = var.dev_ops_tags
  depends_on = [
    module.vpc,
  ]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = sort(data.aws_vpcs.vpc_info.ids)[0]

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.dev_ops_tags
}

module "ec2_instances" {
  key_name = aws_key_pair.dev_ops_pub_key.key_name
  source   = "terraform-aws-modules/ec2-instance/aws"
  version  = "2.12.0"

  name           = "my-ec2-cluster"
  instance_count = 1

  ami                    = "ami-0194c3e07668a7e36"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id              = module.vpc.public_subnets[0]
  
  tags = var.dev_ops_tags
}