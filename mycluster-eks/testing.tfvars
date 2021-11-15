# Provider config
profile         = "ph"   # AWS profile https://amzn.to/2IgHGCs
region          = "us-east-1" # See regions of AWS https://amzn.to/3khGP21
environment     = "testing"
address_allowed = "179.189.27.166/32" # My house public IP Address

# Get AWS ACCOUNT-ID with command:
# aws sts get-caller-identity --query Account --output text --profile PROFILE_NAME_AWS
# Reference: https://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html

# Networking
subnets = ["subnet-08e7e62778c92ea8a", "subnet-051134c9b667b3668"]
vpc_id  = "vpc-091459ce39e55542e"

# EKS
cluster_name                             = "phclst-eks-testing"
cluster_version                          = "1.19"
lt_name                                  = "phclst-ec2"
autoscaling_enabled                      = true
# https://aws.amazon.com/ec2/pricing/on-demand/
override_instance_types                  = ["t3.micro", "t3a.micro"]
on_demand_percentage_above_base_capacity = 50
asg_min_size                             = 2
asg_max_size                             = 4
asg_desired_capacity                     = 2
root_volume_size                         = 20
aws_key_name                             = "aws-testing"
public_ip                                = false
cluster_endpoint_public_access           = true
cluster_endpoint_public_access_cidrs     = ["0.0.0.0/0"]
cluster_endpoint_private_access          = true
cluster_endpoint_private_access_cidrs    = ["0.0.0.0/0"]
kubelet_extra_args                       = "--node-labels=node.kubernetes.io/lifecycle=spot"
suspended_processes                      = ["AZRebalance"]
cluster_enabled_log_types                = ["api", "audit"]
cluster_log_retention_in_days            = "7"
workers_additional_policies              = [
  "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
  "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
  "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
  "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
  "arn:aws:iam::407216465053:policy/eks_cluster_autoscaler", # trocar account id
  "arn:aws:iam::407216465053:policy/aws_lb_controller" #trocar accoun id
]

worker_additional_security_group_ids     = ["sg-0909e063a6a89ae3e"]

map_roles = [
  {
    #rolearn  = "arn:aws:iam::407216465053:role/ph"
    rolearn  = "arn:aws:iam::407216465053:role/pheks"
    username = "Admin"
    #groups   = ["Admin"]
    groups   = ["system:masters"]
  },
]

map_users = [
  {
    userarn  = "arn:aws:iam::407216465053:user/ph"
    username = "ph"
    #groups   = ["Admin"]
    groups   = ["system:masters"]
  },
]

# General
tags = {
  Scost                                             = "testing",
  Terraform                                         = "true",
  Environment                                       = "testing",
  "k8s.io/cluster-autoscaler/enabled"               = "true",
  "k8s.io/cluster-autoscaler/phclst-eks-testing" = "owned"
  "kubernetes.io/cluster/phclst-eks-testing"     = "owned"
}