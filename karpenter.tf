# Karpenter Node Provisioner
# Modern alternative to managed node groups for EKS
# Automatically right-sizes compute based on pod requirements

# module "karpenter" {
#   source  = "terraform-aws-modules/eks/aws//modules/karpenter"
#   version = "~> 20.0"
#
#   cluster_name           = module.eks.cluster_name
#   irsa_oidc_provider_arn = module.eks.oidc_provider_arn
#
#   tags = local.tags
# }

# resource "kubectl_manifest" "karpenter_node_pool" {
#   yaml_body = <<-YAML
#     apiVersion: karpenter.sh/v1beta1
#     kind: NodePool
#     metadata:
#       name: default
#     spec:
#       template:
#         spec:
#           requirements:
#             - key: "karpenter.k8s.aws/instance-category"
#               operator: In
#               values: ["c", "m", "r"]
#             - key: "karpenter.sh/capacity-type"
#               operator: In
#               values: ["spot", "on-demand"]
#       limits:
#         cpu: 100
#       disruption:
#         consolidationPolicy: WhenUnderutilized
#   YAML
# }
