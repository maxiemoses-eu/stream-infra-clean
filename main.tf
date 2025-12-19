module "vpc" {
  source               = "./modules/vpc"
  env                  = var.env
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  # FIX: Rename to eip_ids and wrap in brackets [] to make it a list
  eip_ids = [var.eip_id]
}

module "iam" {
  source = "./modules/iam"
  env    = var.env
}

module "eks" {
  source = "./modules/eks"
  env    = var.env
  # FIX: Pass the VPC ID from the VPC module output
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

module "s3_backend" {
  source          = "./modules/s3_backend"
  env             = var.env
  bucket_name     = var.bucket_name
  lock_table_name = var.lock_table_name
}