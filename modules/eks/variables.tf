variable "cluster_role_arn" {
  description = "The IAM Role ARN for the EKS control plane service."
  type        = string
}

variable "node_role_arn" {
  description = "The IAM Role ARN that the EKS worker nodes will assume."
  type        = string
}

variable "node_desired_size" {
  description = "The desired number of worker nodes to launch initially."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "The minimum number of worker nodes for the Auto Scaling Group."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "The maximum number of worker nodes for the Auto Scaling Group."
  type        = number
  default     = 5
}

variable "instance_types" {
  description = "A list of EC2 instance types to use for the worker nodes (e.g., ['t3.medium'])."
  type        = list(string)
  default     = ["t3.small"]
}

variable "kube_version" {
  description = "The Kubernetes version to use for the EKS cluster (e.g., '1.28')."
  type        = string
  default     = "1.28"
}

variable "allowed_external_cidrs" {
  description = "CIDR blocks allowed to access the public EKS API endpoint (e.g., your office/VPN IPs)."
  type        = list(string)
  default     = ["0.0.0.0/0"] 
}

variable "ssh_key_name" {
  description = "The EC2 Key Pair name for SSH access to worker nodes (REQUIRED for remote_access)."
  type        = string
  default     = null
}

# --- NEW VARIABLES ADDED BELOW ---

variable "env" {
  description = "The environment name (e.g., prod) used for tagging StreamlinePay resources."
  type        = string
}

variable "private_subnet_ids" {
  description = "The list of private subnet IDs where EKS worker nodes will be deployed."
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster and nodes will be deployed."
  type        = string
}