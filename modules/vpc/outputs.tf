output "vpc_id" {
  description = "The ID of the primary VPC provisioned."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "A list of IDs for the Public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "A list of IDs for the Private subnets."
  value       = aws_subnet.private[*].id
}