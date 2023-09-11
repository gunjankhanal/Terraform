#main.tf

provider "aws" {
  region     = "eu-central-1"
  shared_credentials_files = ["/Users/rahulwagh/.aws/credentials"]
}

resource "aws_instance" "ec2_example" {
  ami           = "ami-0767046d1677be5a0"
  instance_type =  "t2.micro"
  tags = {
    Name = "Terraform EC2 "
  }
}

# The following null resource will print message "Hello World"
resource "null_resource" "null_resource_simple" {
  provisioner "local-exec" {
    command = "echo Hello World"
  }
}

========================================================================================

#main.tf 

provider "aws" {
  region     = "eu-central-1"
  shared_credentials_files = ["/Users/rahulwagh/.aws/credentials"]
}

resource "aws_instance" "ec2_example" {
  ami           = "ami-0767046d1677be5a0"
  instance_type =  "t2.micro"
  tags = {
    Name = "Terraform EC2 "
  }
}

# The following null resource has the trigger
resource "null_resource" "null_resource_simple" {
  
  # This trigger will only execute once when it detects the instance id of EC2 instance, or some changes seen in the id of ec2_instance
  triggers = {
    id = aws_instance.ec2_example.id    # to execute it every time replace - id = time()
  }
  provisioner "local-exec" {
    command = "echo Hello World"
  }
}
