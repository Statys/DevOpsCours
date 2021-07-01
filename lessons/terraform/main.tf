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

#resource "aws_ebs_volume" "test_volume" {
#  availability_zone = "eu-west-2"
#  size = 10
#}

resource "aws_instance" "app_server" {
  ami           = "ami-0194c3e07668a7e36"
  instance_type = "t2.micro"

  ebs_block_device{
      device_name = "/dev/sdf"
      volume_size = 9
    }

  count = 1
  security_groups = ["dev-ops-cours"]
  tags = {
    Name = "EC2DevOpsCourse"
    SuperTag = "HuH"
  }
}

#resource "aws_volume_attachment" "test-attach"{
#  device_name = "/dev/sdb"
#  volume_id   = aws_ebs_volume.test_volume.id
#  instance_id = aws_instance.app_server[count.index].id
#}

output "instance_public_ip" {
  value       = aws_instance.app_server[0].public_ip
}