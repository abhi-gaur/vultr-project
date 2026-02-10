# Setup & Deployment Guide  
**DevOps – Vultr Kubernetes Platform**

---

## Overview

This document provides a **complete, end-to-end guide** for setting up infrastructure, deploying applications, enabling observability, and automating CI/CD on **Vultr Kubernetes Engine (VKE)**.

It is written to:
- Demonstrate **senior-level DevOps thinking**
- Explain **why decisions were made**, not just *what was done*
- Help reviewers understand **troubleshooting, trade-offs, and learnings**

---

## Table of Contents

1. Prerequisites  
2. Infrastructure Provisioning (Terraform)  
3. Kubernetes Cluster Bootstrap  
4. Service Mesh & Gateway Setup  
5. Application Containerization  
6. Application Deployment (Kustomize)  
7. CI/CD Automation (GitHub Actions)  
8. Observability (Prometheus & Grafana)  
9. Public Exposure & Routing  
10. Rollback & Recovery Strategy  
11. Troubleshooting & Lessons Learned  

---

## 1. Prerequisites

### Local Machine
- macOS / Linux
- Docker (with `buildx`)
- kubectl `>= v1.27`
- Helm `>= v3`
- Terraform `>= v1.5`
- GitHub account

### Cloud
- Vultr account
- Vultr API key
- Vultr Container Registry (VCR) enabled

---

## 2. Infrastructure Provisioning (Terraform)

### Tools Used
- Terraform
- Vultr Terraform Provider
- Vultr Kubernetes Engine (VKE)

### Infrastructure Components
- Managed Kubernetes Cluster
- Worker Node Pool
- Container Registry
- CSI Driver for Persistent Volumes

### Key Files

infra/
├── main.tf
├── providers.tf
├── variables.tf
├── versions.tf
├── terraform.tfvars

    cd infra
    terraform init
    terraform plan
    terraform apply

### Output:
[========]

- Kubernetes API endpoint
- Cluster ID
- Node pool details
- Learning
.
## 4. Service Mesh & Gateway Setup

### Why Istio Ambient Mode?
- No sidecar injection overhead
- Built-in mTLS
- Cleaner operational model
- Perfect for platform-style assignments

### Components Installed
- Istio control plane
- ztunnel (ambient dataplane)
- Istio Gateway API controller


#### Namespace Configuration
    kubectl label namespace app istio.io/dataplane-mode=ambient


## 5. Application Containerization
### Backend

- FastAPI
- Uvicorn
- Non-root execution
- Multi-stage Dockerfile
- Multi-architecture (amd64, arm64)

### Frontend

- Static HTML
- NGINX unprivileged image
- Security hardened

#### Image Build Example
```yaml
docker buildx build --platform linux/amd64,linux/arm64 \
  -t blr.vultrcr.com/devopsassignment/backend:<version> \
  --push apps/backend
```

## 6. Application Deployment (Kustomize)

#### Structure
    .
    ├── apps
    │   ├── backend
    │   │   ├── app
    │   │   │   └── main.py
    │   │   ├── Dockerfile
    │   │   ├── requirements.txt
    │   │   └── test.sh
    │   ├── frontend
    │   │   ├── Dockerfile
    │   │   └── index.html
    │   └── k8s
    │       ├── base
    │       │   ├── backend
    │       │   │   ├── deployment.yaml
    │       │   │   ├── hpa.yaml
    │       │   │   ├── pdb.yaml
    │       │   │   └── service.yaml
    │       │   ├── frontend
    │       │   │   ├── deployment.yaml
    │       │   │   └── service.yaml
    │       │   ├── gateway
    │       │   │   ├── grafana-httproute.yaml
    │       │   │   ├── httproute.yaml
    │       │   │   └── prometheus-httproute.yaml
    │       │   └── kustomization.yaml
    │       ├── gateway
    │       │   ├── gateway.yaml
    │       │   └── kustomization.yaml
    │       └── overlays
    │           ├── dev
    │           ├── prod
    │           │   └── kustomization.yaml
    │           └── staging

#### Features Implemented

**-HPA
-PDB
-Pod Anti-Affinity
-Resource Limits
-Securitycontext (Non-Root, No Privileges)
-Health Probes
-Startup Probes**

## Deploy
    kubectl apply -k apps/k8s/gateway
    kubectl apply -k apps/k8s/overlays/prod -n app

## 7. CI/CD Automation (GitHub Actions)

#### CI Pipeline
`File: .github/workflows/ci-build-scan.yaml`

Features:

- Multi-arch Docker builds
- Version auto-increment
- Push to Vultr Container Registry
- Trivy vulnerability scan
- Git tag creation

#### CD Pipeline

`File: .github/workflows/cd-deploy.yaml`

Features:

- Uses latest image tags
- Rolling deployments
- Rollout verification
- Automatic failure detection

Secrets Used

**    VULTR_CR_USERNAME
    VULTR_CR_PASSWORD
    KUBECONFIG**


## 8. Observability (Prometheus & Grafana)

#### Stack

- kube-prometheus-stack
- Grafana
- Prometheus
- Node Exporter
- Alertmanager

#### Grafana

- Deployed via Helm
- Secured with admin credentials
- Exposed via Gateway API

#### Learning

```go
Sidecar-based Grafana dashboards caused SSL issues — resolved by disabling SSL verification for Kubernetes API access.
```


## 9. Public Exposure & Routing

### Gateway API

- **Gateway**: public-gateway (istio-system)
- **HTTPRoute**: app-route (app namespace)



## 10. Rollback & Recovery Strategy

#### Kubernetes

    kubectl rollout undo deployment/backend -n app
    

#### CI/CD

- Failed image → deployment blocked
- Health checks prevent bad rollout
- Old replicas remain running


## 11. Troubleshooting & Lessons Learned

### Common Issues Faced

- Registry auth failures
- Multi-arch image push timeouts
- Kustomize path resolution errors
- Istio Gateway namespace mismatch
- uvicorn missing from PATH
- ImagePullBackOff due to tag mismatch

### Key Learnings

- Separate Gateway resources from application overlays
- Never hardcode image tags in manifests
- Always verify container entrypoints
- Ambient mesh simplifies operations significantly
- Observability setup requires environment-specific tuning

