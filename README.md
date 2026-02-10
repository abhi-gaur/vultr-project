# 🚀 vultr-project – Production-Grade Kubernetes Platform on Vultr

This repository demonstrates a **production-ready DevOps platform** built on **Vultr Kubernetes Engine (VKE)** using **Terraform, Kubernetes, Istio (Ambient Mode), GitHub Actions CI/CD, and modern observability tooling**.

The assignment focuses on **real-world DevOps practices**:
- Infrastructure as Code
- Secure containerization
- Multi-environment Kubernetes deployments
- Automated CI/CD
- Service Mesh & Gateway API
- Observability and reliability engineering

> ⚙️ Built, broken, fixed, optimized, and documented like a **Senior DevOps Engineer** would do.

---

## 🌐 Live URLs (Submission Requirement)

| Component | URL |
|---------|-----|
| **Frontend UI** | `http://139.84.222.16/` |
| **Backend Health API** | `http://139.84.222.16/api/health` |
| **Backend Readiness API** | `http://139.84.222.16/api/ready` |
| **Grafana Dashboard** | `http://139.84.222.16/grafana` |

Grafana 

user - admin
pass - 8DPxvZNj35AXyPGmDp4n0yKfapW42hfky0EGVPLO

---

## 🧠 What This Project Demonstrates

✔ End-to-end DevOps ownership  
✔ Cloud-native architecture design  
✔ Secure Kubernetes workloads  
✔ GitOps-style CI/CD automation  
✔ Production troubleshooting & resilience  

---

## 🏗 Architecture Overview

- **Cloud Provider:** Vultr
- **Kubernetes:** Vultr Kubernetes Engine (VKE)
- **IaC:** Terraform
- **Service Mesh:** Istio Ambient Mode (mTLS enabled)
- **Ingress:** Kubernetes Gateway API (Istio Gateway Controller)
- **CI/CD:** GitHub Actions
- **Registry:** Vultr Container Registry
- **Observability:** Prometheus + Grafana
- **Secrets:** Kubernetes Secrets (Vault ready)

📘 Detailed architecture diagrams and flows are documented in  
➡ **[Docs/architecture.md](Docs/architecture.md)**

---

## ⚙️ Deployment & Operations

- Multi-stage, multi-arch Docker builds (amd64 + arm64)
- Kustomize-based Kubernetes manifests
- Automated rollout verification
- Health checks (liveness, readiness, startup)
- HPA, PDB, resource limits, and security contexts

📘 Full setup and operational guide available at  
➡ **[Docs/setup-guide.md](Docs/setup-guide.md)**

---

## 🧪 CI/CD Pipeline Summary

**CI (Build & Scan):**
- Build backend & frontend images
- Multi-arch buildx
- Push to Vultr Container Registry
- Trivy vulnerability scan
- Automated version tagging

**CD (Deploy):**
- Pull latest image versions
- Update Kubernetes deployments
- Rollout verification
- Automatic failure detection

---

## 🔐 Security Highlights

- Containers run as **non-root**
- Read-only root filesystem
- Capability drops (`ALL`)
- mTLS enforced via Istio Ambient Mode
- Secrets stored securely (Vault-ready architecture)

---

## 📈 Observability

- Prometheus for metrics
- Grafana for visualization
- Kubernetes-native monitoring stack
- Health-based traffic routing

---


## 🙌 Final Note

This assignment was **challenging, exciting, and deeply educational**.

It involved:
- Designing systems
- Debugging production failures
- Understanding cloud networking
- Applying DevOps best practices end-to-end

> 💙 Thank you to the stakeholders for this opportunity.  
> I hope you enjoy reviewing this platform as much as I enjoyed building it.

🚀 **Please feel free to explore, test, and rate this work!**
