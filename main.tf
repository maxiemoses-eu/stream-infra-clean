module "vpc" {
  source               = "./modules/vpc"
  env                  = var.env
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  eip_ids              = var.eip_ids
}

module "iam" {
  source = "./modules/iam"
  env    = var.env
}

module "eks" {
  source = "./modules/eks"
  env    = var.env
  
  # NEW: Add this line to pass the version to the EKS module
  version            = var.eks_version 
  
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  node_role_arn      = module.iam.eks_node_role_arn
  node_desired_size  = var.node_desired_size
  node_min_size      = var.node_min_size
  node_max_size      = var.node_max_size
  instance_types     = var.instance_types
}

module "ecr" {
  source = "./modules/ecr"
  env    = var.env
  repos  = var.ecr_repos
}

# CRITICAL: Comment out this module now.
# You have already created the bucket/table, and Terraform is 
# currently using them for the backend. Trying to manage them 
# as resources inside the state causes the 409 Conflict error.
/*
module "s3_backend" {
  source          = "./modules/s3_backend"
  env             = var.env
  bucket_name     = var.bucket_name
  lock_table_name = var.lock_table_name
}
*/