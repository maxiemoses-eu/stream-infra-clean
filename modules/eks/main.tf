resource "aws_eks_cluster" "main" {
  name     = "${var.env}-eks-cluster"
  role_arn = var.cluster_role_arn
  version  = var.kube_version # Set specific Kubernetes version

  # CRITICAL OBSERVABILITY FIX: Enable all control plane logs to CloudWatch
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"] 

  vpc_config {
    # Use all private subnets for EKS
    subnet_ids             = aws_subnet.private[*].id 
    
    # CRITICAL SECURITY FIX: Restrict public access to the API server
    endpoint_private_access = true 
    endpoint_public_access  = true
    public_access_cidrs     = var.allowed_external_cidrs # Use defined CIDRs
  }

  tags = {
    Environment = var.env
  }
}

resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.env}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = aws_subnet.private[*].id # Use all private subnets

  scaling_config {
    desired_size = var.node_desired_size
    min_size     = var.node_min_size
    max_size     = var.node_max_size
  }

  instance_types = var.instance_types

  # ADDED: Configuration for controlled node updates (max one unavailable at a time)
  update_config {
    max_unavailable = 1
  }

  # ADDED (Optional): Allows SSH access to nodes for debugging
  dynamic "remote_access" {
    for_each = var.ssh_key_name != null ? [1] : []
    content {
      ec2_ssh_key = var.ssh_key_name
    }
  }

  tags = {
    Environment = var.env
  }

  depends_on = [aws_eks_cluster.main]
}