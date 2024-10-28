variable "name" {
  description = "Name of the project and cluster"
  type        = string
  default     = "fully-private-cluster"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "enable_amazon_prometheus" {
  description = "Enable AWS Managed Prometheus service"
  type        = bool
  default     = true
}
