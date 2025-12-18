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

output "cluster_name" {
  description = "The name of the EKS Kubernetes cluster."
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "The HTTP endpoint for the EKS control plane API."
  value       = aws_eks_cluster.main.endpoint
  sensitive   = true # Mark as sensitive for security
}

output "kubectl_config_command" {
  description = "Command to configure kubectl to connect to the cluster. NOTE: You must replace 'YOUR_AWS_REGION' with the actual region."
  value       = "aws eks update-kubeconfig --name ${aws_eks_cluster.main.name} --region YOUR_AWS_REGION"
}