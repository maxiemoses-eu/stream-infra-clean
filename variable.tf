variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "env" {
  type    = string
}

variable "vpc_cidr" {
  type    = string
}

variable "public_subnet_cidrs" {
  type    = list(string)
}

variable "private_subnet_cidrs" {
  type    = list(string)
}

variable "azs" {
  type    = list(string)
}

variable "eip_ids" {
  type        = list(string)
  description = "List of Elastic IP IDs for NAT Gateway"
}

variable "ecr_repos" {
  type    = list(string)
}

variable "eks_version" {
  type    = string
  default = "1.31"
}

variable "node_desired_size" {
  type    = number
}

variable "node_min_size" {
  type    = number
}

variable "node_max_size" {
  type    = number
}

variable "instance_types" {
  type    = list(string)
}

variable "bucket_name" {
  type = string
}

variable "lock_table_name" {
  type = string
}