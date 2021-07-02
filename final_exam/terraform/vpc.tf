terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.27"
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
  #public_key = file("/home/statys/.ssh/id_rsa.pub")
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFt6LhKZPEIxwSY+gizywj/dnmGtJU9sI1QgsCvI77YeDcof52/A0RepgXMR5s4wLVGuXUxv0fV6IiRQYEhl7dHXjmH0WJ2bLr3LI3TVmTVf5xYUrqlnoiAumb6rrisXyy3mSQxM4rZHziICeirnVyUtsKK5ip9v/vUaa1NmWtj1azU3Ar9Y4tDZZT6v0XVpFOFj3XVAUriwVJGwuzK/nJ9rAhddqmkbUn8hU1KyrqX+tJ2Gzt03MVE/KugIgE7gAAxMTzZ+DAzlwi9DzyqMDotog3KlQN8LIe/FlCNeT6PQydxG6JtcEc2NvaArOpGdLmRXV1nbN1oCtqee49nqvTz2ahhyCLUcTyDvMNku9nz0AVABbIQmovHMh3a2rwiaVt6LL+zKEx3XjLE1fp4vakaCPyG7bgKqtcVT7o2hZWZ5WsvXnIxzBcMacku0hhWN/jQgdCQKQWMRjR5BMYf4vQVkBJGM52PsShLAQKS5I7YTIIIEX+vPmO8LR3vM5VSFE= statys@DESKTOP-TTUINVV"
}
1
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

resource "aws_security_group" "dev_ops_sg" {
  name        = "dev_ops_sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = sort(data.aws_vpcs.vpc_info.ids)[0]

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = merge(var.dev_ops_tags,
    {
      Name = "dev_ops_sg"
    }
  )
}

module "ec2_instances" {
  key_name = aws_key_pair.dev_ops_pub_key.key_name
  source   = "terraform-aws-modules/ec2-instance/aws"
  version  = "2.12.0"

  name           = "my-ec2-cluster"
  instance_count = 1

  ami                    = "ami-0194c3e07668a7e36"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dev_ops_sg.id]
  subnet_id              = module.vpc.public_subnets[0]
  
  tags = var.dev_ops_tags
}


/* resource "aws_eip" "eip" {
  instance = module.ec2_instances.id[0]
  vpc      = true
} */