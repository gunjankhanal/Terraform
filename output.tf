
output "my_ec2_publicip" {
  value = aws_instance.my_ec2_instancee.public_ip
}

output "my_ec2_private_ip" {
  value = aws_instance.my_ec2_instancee.private_ip
}
output "my_ec2_arn" {
  value = aws_instance.my_ec2_instancee.arn
}