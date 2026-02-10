# Stacks demo: Network → EKS → Kubernetes app (deferred orchestration, multi-env)

This PR adds a complete **Terraform Stacks** demo that mirrors the Episode 1 lightboard flow:

- **Components**: `network` (VPC + public subnets), `cluster` (EKS), `app` (Kubernetes Deployment+Service)
- **Centralized providers** at the Stack level (DRY + governance)
- **Deferred orchestration**: Kubernetes provider reads outputs from the EKS component; Stacks automatically defers planning/applying the app until those values exist (no wrapper scripts)
- **Deployments**: development, staging, production — same blueprint, different inputs/regions

## Why this design

- Stacks GA uses `.tfcomponent.hcl` to define components/providers and `.tfdeploy.hcl` to define deployments (instances). This gives dependency-aware orchestration and repeatable environments from a single blueprint.  
- The `kubernetes` provider is configured from the `cluster` component outputs; HCP Terraform detects this dependency and defers the app until EKS is ready.  
- Provider pinning and config live at the Stack top level to keep teams aligned on versions and auth.

## How to use (UI flow)

1. Create a **Stack** in HCP Terraform and connect this repo.  
2. In `deployments.tfdeploy.hcl`, paste your **AWS `role_arn`** per environment (from the identity-token/role setup) and push.  
3. Open each deployment (dev/staging/prod) and **Approve plan**. You’ll briefly see **Deferred** for the app while the cluster is coming online—Stacks will proceed automatically.

## Change once, roll everywhere

- Edit `modules/app/main.tf` → set `replicas = 3`, commit & push.
- Approve dev → staging → prod, demonstrating a consistent rollout of the same change across deployments.

---

> References for the team (not embedded in repo):
> - Stacks language & workflow (GA, components/deployments).  
> - `terraform stacks` CLI reference.  
> - EKS deferred orchestration tutorial (K8s provider from EKS outputs).  
> - EKS module & Kubernetes provider docs.
``