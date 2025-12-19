module "production_infrastructure" {
  source = "../../"

  # Pass variables from your prod.tfvars into the root modules
  env                  = var.env
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  
  # FIXED: Changed from eip_id to eip_ids to match the new list format
  eip_ids              = var.eip_ids
  
  node_desired_size    = var.node_desired_size
  node_min_size        = var.node_min_size
  node_max_size        = var.node_max_size
  instance_types       = var.instance_types
  ecr_repos            = var.ecr_repos

  # S3 and DynamoDB backend variables
  bucket_name          = var.bucket_name
  lock_table_name      = var.lock_table_name
}