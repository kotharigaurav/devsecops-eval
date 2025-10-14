variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for EKS"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for EKS"
}
