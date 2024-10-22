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
