# Kyverno Policy Engine
# Kubernetes-native policy management for security and compliance
# Validates, mutates, and generates Kubernetes resources

# resource "helm_release" "kyverno" {
#   name             = "kyverno"
#   repository       = "https://kyverno.github.io/kyverno"
#   chart            = "kyverno"
#   version          = "3.1.4"
#   namespace        = "kyverno"
#   create_namespace = true
# }

# resource "kubectl_manifest" "require_labels" {
#   yaml_body = <<-YAML
#     apiVersion: kyverno.io/v1
#     kind: ClusterPolicy
#     metadata:
#       name: require-labels
#     spec:
#       validationFailureAction: Enforce
#       rules:
#         - name: require-team-label
#           match:
#             any:
#               - resources:
#                   kinds:
#                     - Deployment
#                     - StatefulSet
#           validate:
#             message: "The label 'team' is required."
#             pattern:
#               metadata:
#                 labels:
#                   team: "?*"
#   YAML
#   depends_on = [helm_release.kyverno]
# }

# resource "kubectl_manifest" "disallow_privileged" {
#   yaml_body = <<-YAML
#     apiVersion: kyverno.io/v1
#     kind: ClusterPolicy
#     metadata:
#       name: disallow-privileged-containers
#     spec:
#       validationFailureAction: Enforce
#       rules:
#         - name: deny-privileged
#           match:
#             any:
#               - resources:
#                   kinds:
#                     - Pod
#           validate:
#             message: "Privileged containers are not allowed."
#             pattern:
#               spec:
#                 containers:
#                   - securityContext:
#                       privileged: "false"
#   YAML
#   depends_on = [helm_release.kyverno]
# }
