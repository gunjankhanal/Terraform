terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.91.0"
    }
  }
  
  backend "s3" {
    bucket         = "gunjan-bucket-march11"
    key            = "terraform-state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "mydynamodb"
  }

}

provider "aws" {
  region = var.aws_region
}

locals {
  instance_tag_name = "${terraform.workspace}-instance"
}

resource "aws_instance" "my-ec2-instance" {
    ami = var.machine_id
    instance_type = var.instance_type
    availability_zone  = "us-east-1a"
    key_name = "Gunjan-jan9"
    tags = {
        Name = local.instance_tag_name
    }
  
  provisioner "file" {
    source = "conf/myapp.conf"
    destination = "/home/ubuntu/myapp.conf"
  }
  provisioner "file" {
    source = "conf/myscript.sh"
    destination = "/home/ubuntu/myscript.sh"
  }

   provisioner "local-exec" {
    command = "echo ${self.private_ip} >> information.txt"
  }
   provisioner "local-exec" {
    command = "echo ${self.public_ip} >> information.txt"
  }
  provisioner "local-exec" {
     environment = {
      FOO = "bar"
      BAR = 1
      BAZ = "true"
    }
    command = "echo $FOO $BAR $BAZ >> information.txt"
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /home/ubuntu/myscipt.sh",
      "bash /home/ubuntu/myscript.sh",
     ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/Gunjan-jan9.pem")  
    host        = self.public_ip
  }  

}

data "aws_ebs_volume" "my_ebs_volume" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = ["gp3"]
  }

  filter {
    name   = "tag:Name"
    values = ["myebs-vol1"]
  }
}

resource "aws_volume_attachment" "my_ebs_volume_attachment" {
  device_name = "/dev/sdh"
  volume_id   = data.aws_ebs_volume.my_ebs_volume.id
  instance_id = aws_instance.my-ec2-instance.id
}

module "my_new_s3_bucket" {
 source = "./modules/aws-s3-static-website-bucket"
  bucket_name = "gunjan-testbucket-05"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}

module "my-security-groups" {
  source = "./modules/security-group"
  vpc_id = var.vpc_id

}