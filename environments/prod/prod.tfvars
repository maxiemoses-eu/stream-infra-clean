# 🌍 Environment Configuration
env        = "prod"
aws_region = "us-west-2"

# 🌐 VPC Networking
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
azs                  = ["us-west-2a", "us-west-2b"]
eip_id               = "eipalloc-0fbc73e9be8ebb30b" # Replace with your real EIP ID from AWS

# 🐳 ECR Repositories
ecr_repos = [
  "cart-cna-microservice",
  "users-cna-microservice",
  "products-cna-microservice",
  "store-ui"
]

# ☸️ EKS Cluster
node_desired_size = 2
node_max_size     = 3
node_min_size     = 1
instance_types    = ["t3.small"]

# 🗃️ Remote State Backend (These are managed in backend.tf, but kept here for reference)
bucket_name     = "streamlinepay-terraform-state"
lock_table_name = "streamlinepay-terraform-locks"