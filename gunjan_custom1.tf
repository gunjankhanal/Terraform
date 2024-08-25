terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.63.0"
    }
  }
  backend "s3" {
    bucket = "tech-test.techaxis.com"
    key = "terraform-state/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "mydynamodb"
 }

}

provider "aws" {
    region = "us-east-1"
}


resource "aws_instance" "my_ec2_instancee" {
  
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  key_name = "aws_key"
  tags = {
    Name = "My First EC2"
  }

  provisioner "file" {
    source      = "conf/myapp.conf"
    destination = "/home/ubuntu/myapp.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/aws_key")  
    host        = self.public_ip
  }  
 }

resource "aws_key_pair" "deploykey" {
  key_name = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDwDiNvjTGA3I6K4LTgJHQ0sDRUK/Yj7+jGPF4oTr+npCkJDIQf84OQIo0rnwvjUCdRaTTdSDO3G/ULZWqnH1mNTt31/YXDAUCtBmxVFORhg10Sy3+I3zLBf2cw9unramTEs76RWnrZJbslrzJ3kOGJJBvuqExuV0AGy0HklEowDNIspTjV0ylrqS3n10Jh/p3yMFxDsoXjxxhNIoJifs39sVyxvx7QBPo4l7QPOJcI1Kud9J0XmnY/AjE8SPlGmQqazXnJ24XGjXiXw+4cd6TbjOMHCFUJ7jFOe0o/+wM58XLE3HfajsZ8lBRAK8dZ/zvhnNJxpthJ8VejyJQ6VyA3EYqHiGgeAW7mTE3/m1ePuM6A+TQnsPl3vRNjvQMVtLfHxoiWsWh9OQrKtnBhsg6yDnxq507rMIZvh32mvyt5XMlTsHQX198l8rXdo+EPGir8/gXL8CMp/bUb2NVj4rKxCcY9xu36Nt0z9vS8djrelKUP3k8+uv9P0A4DZYRtWf8= user@LAPTOP-R5DUVG7S"
  
}
