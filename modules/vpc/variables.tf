variable "env" {
  description = "The deployment environment (e.g., dev, staging, prod). REQUIRED for naming."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the main VPC (e.g., 10.0.0.0/16)."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for Public subnets (must match AZs for HA)."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for Private subnets (must match AZs for HA)."
  type        = list(string)
}

variable "azs" {
  description = "List of Availability Zones to use (must match subnet count)."
  type        = list(string)
}

variable "eip_ids" {
  description = "List of Allocation IDs for pre-allocated Elastic IPs (one for each NAT Gateway/AZ)."
  type        = list(string)
}