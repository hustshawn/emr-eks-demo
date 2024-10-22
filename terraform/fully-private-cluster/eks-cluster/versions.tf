terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.34"
    }
  }

  ##  Used for end-to-end testing on project; update to suit your needs
  backend "s3" {
    bucket = "tf-eks-remote-states"
    region = "ap-southeast-1"
    key    = "e2e/fully-private-cluster/eks-cluster/terraform.tfstate"
  }
}
