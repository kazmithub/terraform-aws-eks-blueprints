# AWS EKS Blueprints - Platform Engineering

Production-ready EKS platform with GitOps (ArgoCD), secret management (Vault), policy enforcement (Kyverno), and observability (Prometheus).

## Architecture

```
Developer Push --> ArgoCD (GitOps) --> EKS Cluster
                                         |
                  +----------------------+----------------------+
                  |                      |                      |
            Application Pods      Platform Addons         Security Layer
            (Helm Releases)            |                      |
                                       +-- CoreDNS            +-- Kyverno Policies
                                       +-- Cert Manager       +-- Network Policies
                                       +-- Metrics Server     +-- IRSA (OIDC)
                                       +-- Cluster Autoscaler +-- External Secrets
                                       +-- Traefik Ingress
                                       +-- Prometheus/Grafana

Secrets: AWS Secrets Manager --> External Secrets Operator --> K8s Secrets
Nodes:   Karpenter / Managed Node Groups (AMD64 + ARM64)
```

## Key Features

- **GitOps with ArgoCD** - Declarative, Git-driven continuous delivery
- **HashiCorp Vault** - Centralized secrets management with Kubernetes auth
- **External Secrets Operator** - Cloud-native secret synchronization
- **Kyverno Policy Engine** - Kubernetes-native policy enforcement
- **Karpenter** - Intelligent, cost-optimized node provisioning
- **Multi-architecture** - AMD64 and ARM64 node groups
- **Observability** - Prometheus, Grafana, and AlertManager
- **Ingress** - Traefik with TLS via Cert Manager
- **Security** - IRSA, Network Policies, Pod Security Standards

## Prerequisites

- AWS CLI v2 with admin credentials
- Terraform >= 1.5.0
- kubectl >= 1.28
- Helm >= 3.12
- ArgoCD CLI (optional)

## Project Structure

```
.
├── main.tf                  # EKS cluster, VPC, node groups
├── variables.tf             # Input variables
├── outputs.tf               # Cluster outputs
├── karpenter.tf             # Karpenter node provisioner
├── external-secrets.tf      # External Secrets Operator
├── kyverno.tf               # Policy enforcement
├── backend.tf               # S3 remote state
├── modules/                 # Reusable Terraform modules
├── helm-values/             # Helm value overrides
└── .github/workflows/       # CI/CD pipeline
```

## Deployment

```bash
# 1. Initialize Terraform
terraform init

# 2. Review the plan
terraform plan

# 3. Deploy the platform
terraform apply

# 4. Access ArgoCD
kubectl port-forward svc/argocd-server -n argocd 8080:443
# Username: admin
# Password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# 5. Access Grafana
kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80
```

## GitOps Workflow

1. Developer pushes code to application repo
2. CI builds container image and pushes to ECR
3. CI updates Helm values with new image tag
4. ArgoCD detects drift and syncs the desired state
5. Karpenter provisions nodes if needed
6. Kyverno validates the deployment against policies

## Cleanup

```bash
terraform destroy
```

## License

MIT
