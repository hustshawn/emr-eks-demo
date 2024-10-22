# output "configure_kubectl" {
#   description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
#   value       = "aws eks --region ${local.region} update-kubeconfig --name ${module.eks.cluster_name}"
# }

output "vpc_endpoints" {
  description = "VPC Endpoint Names"
  value       = [for endpoint in module.vpc_endpoints.endpoints : endpoint.service_name]
}

# Expected Output
# + vpc_endpoints = [
#     + "com.amazonaws.ap-southeast-1.autoscaling",
#     + "com.amazonaws.ap-southeast-1.ec2",
#     + "com.amazonaws.ap-southeast-1.ec2messages",
#     + "com.amazonaws.ap-southeast-1.ecr.api",
#     + "com.amazonaws.ap-southeast-1.ecr.dkr",
#     + "com.amazonaws.ap-southeast-1.elasticloadbalancing",
#     + "com.amazonaws.ap-southeast-1.kms",
#     + "com.amazonaws.ap-southeast-1.logs",
#     + "com.amazonaws.ap-southeast-1.s3",
#     + "com.amazonaws.ap-southeast-1.ssm",
#     + "com.amazonaws.ap-southeast-1.ssmmessages",
#     + "com.amazonaws.ap-southeast-1.sts",
#   ]
