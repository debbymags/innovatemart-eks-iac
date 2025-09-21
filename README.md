# InnovateMart EKS Microservices Deployment

This project demonstrates deploying a microservices architecture on AWS EKS using Terraform and Kubernetes. The deployment includes three microservices (`orders`, `catalog`, and `carts`) with secrets management and a CI/CD workflow via GitHub Actions.

---

## **Prerequisites / Tools Used**

- AWS Account with permissions for EKS, RDS, DynamoDB, IAM, and S3
- Terraform v1.3+
- kubectl
- GitHub Actions
- Helm

---

## **Project Structure**
```
innovatemart-eks/
├─ terraform/
│ └─ environments/dev/ # Terraform configs for EKS, RDS, DynamoDB
├─ k8s/ # Kubernetes manifests
│ ├─ orders-deployment.yaml
│ ├─ catalog-deployment.yaml
│ ├─ carts-deployment.yaml
│ └─ secrets.yaml
├─ .github/workflows/terraform.yml # CI/CD workflow
└─ README.md
```
---

## **Core Objectives Completed**

1. **EKS Cluster Deployment**
   - Cluster created via Terraform
   - Worker nodes provisioned and joined cluster

2. **Microservices Deployment**
   - `orders`, `catalog`, `carts` pods deployed
   - Services are running and reachable within cluster

3. **Secrets Management**
   - Kubernetes secrets created for database credentials
   - Verified that pods reference secrets in environment variables

4. **Terraform CI/CD**
   - GitHub Actions workflow automates `terraform init`, `plan`, and `apply` on push to main
   - Terraform variables passed via GitHub secrets

5. **Developer Access**
   -  Created an IAM user (`innovatemart-dev`) for the development team
   - Granted read-only access to the EKS cluster resources
   - Developers can view logs, describe pods, and check service status without making changes
---

## **Bonus Objectives (Partial / Attempted)**

- **Managed persistence**
  - AWS RDS for PostgreSQL (`orders`) and MySQL (`catalog`)
  - AWS DynamoDB for `carts`

- **Networking (Documented / Planned)**
  - AWS Load Balancer Controller installation and Ingress configuration documented
  - Plan: expose `ui` service to internet via Application Load Balancer (ALB)
  - Placeholder for domain configuration in Route 53
  - SSL via ACM planned for HTTPS
---

## **Accessing Running App**

```bash
# Check pods are running
kubectl get pods -n default

# Check services
kubectl get svc -n default

# Terraform outputs
terraform -chdir=terraform/environments/dev output
```
---
## **Next Steps / Future Work**

- Automate secrets injection from Terraform outputs to Kubernetes pods

- Complete RDS/DynamoDB integration with pod environment variables

- Configure AWS Load Balancer with HTTPS via ACM

- Implement full CI/CD for database secrets management