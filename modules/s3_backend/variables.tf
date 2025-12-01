variable "env" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket for Terraform state"
}

variable "lock_table_name" {
  type        = string
  description = "Name of the DynamoDB table for state locking"
}
