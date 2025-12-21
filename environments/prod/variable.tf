variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "env" {
  type    = string
  default = "prod"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b"]
}

# FIXED: Changed from eip_id (string) to eip_ids (list of strings)
variable "eip_ids" {
  type        = list(string)
  description = "List of Elastic IP IDs for NAT Gateway(s)"
}

variable "ecr_repos" {
  type = list(string)
  default = [
    "store-ui",
    "cart-microservice",
    "products-microservice",
    "users-microservice",
    "search-microservice"
  ]
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_max_size" {
  type    = number
  default = 3
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.small"]
}

variable "bucket_name" {
  description = "The name of the S3 bucket for Terraform state."
  type        = string
}

variable "lock_table_name" {
  description = "The name of the DynamoDB table for Terraform locks."
  type        = string
}