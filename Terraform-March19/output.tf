output "my_ec2_publicip" {
  value = aws_instance.my-ec2-instance.public_ip
}
output "my_ec2_privatedns" {
  value = aws_instance.my-ec2-instance.private_dns
}

output "my_ec2_arn" {
  value = aws_instance.my-ec2-instance.arn
}
output "my_ec2_hostID" {
  value = aws_instance.my-ec2-instance.host_id
}