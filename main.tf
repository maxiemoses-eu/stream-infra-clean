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
  
  # FIXED: Renamed to 'cluster_version' to avoid Terraform keyword conflict
  # This maps to the 'cluster_version' variable in your EKS module
  cluster_version    = var.eks_version 
  
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

# DISABLED: Prevent Terraform from trying to recreate the backend bucket it is using
/*
module "s3_backend" {
  source          = "./modules/s3_backend"
  env             = var.env
  bucket_name     = var.bucket_name
  lock_table_name = var.lock_table_name
}
*/