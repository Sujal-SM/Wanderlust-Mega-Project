output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.wanderlust_instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.wanderlust_instance.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.wanderlust_instance.public_dns
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.ec2_sg.id
}

output "key_pair_name" {
  description = "Name of the key pair"
  value       = aws_key_pair.deployer.key_name
}