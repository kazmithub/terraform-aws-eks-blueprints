# External Secrets Operator
# Syncs secrets from AWS Secrets Manager / Parameter Store into Kubernetes Secrets
# More secure than direct Vault mounts - follows GitOps principles

# resource "helm_release" "external_secrets" {
#   name             = "external-secrets"
#   repository       = "https://charts.external-secrets.io"
#   chart            = "external-secrets"
#   version          = "0.9.13"
#   namespace        = "external-secrets"
#   create_namespace = true
#
#   set {
#     name  = "installCRDs"
#     value = "true"
#   }
# }

# resource "kubectl_manifest" "cluster_secret_store" {
#   yaml_body = <<-YAML
#     apiVersion: external-secrets.io/v1beta1
#     kind: ClusterSecretStore
#     metadata:
#       name: aws-secrets-manager
#     spec:
#       provider:
#         aws:
#           service: SecretsManager
#           region: ${var.region}
#           auth:
#             jwt:
#               serviceAccountRef:
#                 name: external-secrets-sa
#                 namespace: external-secrets
#   YAML
#   depends_on = [helm_release.external_secrets]
# }
