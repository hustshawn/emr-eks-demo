locals {
  name   = var.name
  region = var.region

  vpc_cidr = "10.8.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  endpoints_list = ["autoscaling", "ecr.api", "ecr.dkr", "ec2", "ec2messages", "elasticloadbalancing", "sts", "kms", "logs", "ssm", "ssmmessages", "emr-containers"]

  vpc = data.terraform_remote_state.network_state.outputs.vpc

  tags = {
    Blueprint  = local.name
    GithubRepo = "github.com/aws-ia/terraform-aws-eks-blueprints"
  }
}

data "aws_availability_zones" "available" {
  # Do not include local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


# Get the state with data resources from s3 bucket tf-eks-remote-states 
data "terraform_remote_state" "network_state" {
  backend = "s3"
  config = {
    bucket = "tf-eks-remote-states"
    key    = "e2e/fully-private-cluster/networking/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

# # A data resource to retrive the vpc by tag, Name -> fully-private-cluster
# data "aws_vpc" "vpc" {
#   filter {
#     name   = "tag:Name"
#     values = ["fully-private-cluster"]
#   }
# }

# output "vpc" {
#   value = data.terraform_remote_state.network_state.outputs.vpc
# }

output "vpc_id" {
  value = local.vpc.vpc_id
}

# # ################################################################################
# # # Cluster
# # ################################################################################

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 20.11"

#   cluster_name    = local.name
#   cluster_version = "1.30"

#   # EKS Addons
#   cluster_addons = {
#     coredns    = {}
#     kube-proxy = {}
#     vpc-cni    = {}
#   }

#   vpc_id     = local.vpc.vpc_id
#   subnet_ids = local.vpc.private_subnets

#   #---------------------------------------
#   # Note: This can further restricted to specific required for each Add-on and your application
#   #---------------------------------------
#   # Extend cluster security group rules
#   cluster_security_group_additional_rules = {
#     ingress_nodes_ephemeral_ports_tcp = {
#       description                = "Nodes on ephemeral ports"
#       protocol                   = "tcp"
#       from_port                  = 1025
#       to_port                    = 65535
#       type                       = "ingress"
#       source_node_security_group = true
#     }
#   }
#   # Extend node-to-node security group rules
#   node_security_group_additional_rules = {
#     ingress_self_all = {
#       description = "Node to node all ports/protocols"
#       protocol    = "-1"
#       from_port   = 0
#       to_port     = 0
#       type        = "ingress"
#       self        = true
#     }
#     ingress_fsx1 = {
#       description = "Allows Lustre traffic between Lustre clients"
#       cidr_blocks = local.vpc.private_subnets_cidr_blocks
#       from_port   = 1021
#       to_port     = 1023
#       protocol    = "tcp"
#       type        = "ingress"
#     }
#     ingress_fsx2 = {
#       description = "Allows Lustre traffic between Lustre clients"
#       cidr_blocks = local.vpc.private_subnets_cidr_blocks
#       from_port   = 988
#       to_port     = 988
#       protocol    = "tcp"
#       type        = "ingress"
#     }
#   }

#   eks_managed_node_group_defaults = {
#     iam_role_additional_policies = {
#       # Not required, but used in the example to access the nodes to inspect mounted volumes
#       AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#     }
#   }

#   eks_managed_node_groups = {
#     #  We recommend to have a MNG to place your critical workloads and add-ons
#     #  Then rely on Karpenter to scale your workloads
#     #  You can also make uses on nodeSelector and Taints/tolerations to spread workloads on MNG or Karpenter provisioners
#     core_node_group = {
#       name        = "core-node-group"
#       description = "EKS managed node group example launch template"

#       min_size     = 1
#       max_size     = 9
#       desired_size = 3

#       instance_types = ["m5.xlarge"]

#       ebs_optimized = true
#       block_device_mappings = {
#         xvda = {
#           device_name = "/dev/xvda"
#           ebs = {
#             volume_size = 100
#             volume_type = "gp3"
#           }
#         }
#       }

#       labels = {
#         WorkerType    = "ON_DEMAND"
#         NodeGroupType = "core"
#       }

#       tags = {
#         Name                     = "core-node-grp",
#         "karpenter.sh/discovery" = local.name
#       }
#     }
#   }

#   tags = local.tags
# }
