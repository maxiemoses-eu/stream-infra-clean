# 🌍 Environment Configuration
project_name = "streamlinepay"
environment  = "prod"
region       = "us-west-2"

# 🔐 IAM
enable_iam = true

# 🌐 VPC Networking
vpc_cidr_block       = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

# 🐳 ECR Repositories
ecr_repositories = [
  "cart-cna-microservice",
  "users-cna-microservice",
  "products-cna-microservice",
  "store-ui"
]

# ☸️ EKS Cluster
eks_cluster_name       = "streamlinepay-prod-cluster"
eks_node_group_name    = "streamlinepay-prod-nodes"
eks_node_instance_type = "t3.small"
eks_desired_capacity   = 2
eks_max_capacity       = 3
eks_min_capacity       = 1

# 🗃️ Remote State Backend
s3_backend_bucket   = "streamlinepay-terraform-state"
s3_backend_key      = "prod/terraform.tfstate"
dynamodb_table_name = "terraform-locks"
