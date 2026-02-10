# 🏗 Architecture Documentation

## 1. High-Level System Architecture

User
│
▼
Public Internet
│
▼
Vultr LoadBalancer
│
▼
Istio Gateway (Gateway API)
│
├── / → Frontend Service (NGINX)
│
└── /api → Backend Service (FastAPI)
│
└── Databases (Postgres / Mongo / Redis)


---

## 2. Component Responsibilities

### Infrastructure Layer
- Terraform provisions:
  - VKE cluster
  - Node pools
  - Networking
  - Registry resources

### Kubernetes Layer
- Namespaces isolate workloads
- Kustomize manages environments
- HPA ensures autoscaling
- PDB ensures availability during disruptions

### Service Mesh
- Istio Ambient Mode
- Zero sidecars
- mTLS enforced transparently
- ZTunnel handles traffic encryption

### Ingress
- Kubernetes Gateway API
- Path-based routing using HTTPRoute
- Production-grade traffic control

---

## 3. CI/CD Architecture

Git Push
│
▼
GitHub Actions (CI)
├── Build Images
├── Scan Vulnerabilities
├── Push to Registry
└── Tag Versions
│
▼
GitHub Actions (CD)
├── Update Deployments
├── Rollout Verification
└── Auto-fail on errors


---

## 4. Observability Stack

- Prometheus scrapes metrics
- Grafana visualizes:
  - Pod health
  - Resource usage
  - Cluster performance

---

## 5. Security Model

- mTLS everywhere
- Non-root containers
- Read-only filesystems
- Minimal permissions
- Secrets abstraction layer

---

## 6. Failure & Recovery Strategy

- HPA scales under load
- PDB prevents downtime
- Rolling updates with health gates
- Automatic rollback on failure

