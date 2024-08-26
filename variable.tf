# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-east-1"
}

variable "image_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-04a81a99f5ec58529" # Amazon2 Linux AMI ID
}

variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
 
}