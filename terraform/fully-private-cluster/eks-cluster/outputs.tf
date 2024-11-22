output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${local.region} update-kubeconfig --name ${module.eks.cluster_name}"
}

# output "vpc_module" {
#   value = data.terraform_remote_state.tf-eks-remote-states
# }

output "vpc_id" {
  value = local.vpc.vpc_id
}

output "emr_containers" {
  value = module.emr_containers
}

# output "karpenter" {
#   value = module.eks_blueprints_addons.karpenter
# }

output "karpenter_resources" {
  value = {
    iam_role_arn               = module.eks_blueprints_addons.karpenter.iam_role_arn
    iam_role_name              = module.eks_blueprints_addons.karpenter.iam_role_name
    node_iam_role_name         = module.eks_blueprints_addons.karpenter.node_iam_role_name
    node_instance_profile_name = module.eks_blueprints_addons.karpenter.node_instance_profile_name
  }
}
