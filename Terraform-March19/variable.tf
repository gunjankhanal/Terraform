variable "machine_id" {
    type = string
    description = "This is an ami_id of EC2 machine"
    default = "ami-04b4f1a9cf54c11d0"
}

variable "aws_region" {
    type = string
    description = "This is the region where the aws instance runs"
    default = "us-east-1"
}
  
variable "instance_type" {
    type = string
    description = "This is the default instance type"
    default = "t2.micro"
}

variable "vpc_id" {
  type = string
  description = "This is the default instance type"
  default = "vpc-0af2e01e0d2905718"
}