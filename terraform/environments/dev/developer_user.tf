# developer_user.tf

resource "aws_iam_user" "dev" {
  name = "innovatemart-dev"
}

# Access keys for CLI/kubectl
resource "aws_iam_access_key" "dev" {
  user = aws_iam_user.dev.name
}


##############################
# Terraform Outputs (for secure sharing)
###############################


output "dev_access_key_id" {
  value = aws_iam_access_key.dev.id
  sensitive = true
}

output "dev_secret_access_key" {
  value     = aws_iam_access_key.dev.secret
  sensitive = true
}

###############################
#IAM policy (read-only for EKS via AWS CLI/EKS API)
###############################

resource "aws_iam_policy" "eks_readonly" {
  name        = "EKSReadOnlyAccessPolicy"
  description = "Read-only access to EKS cluster"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "dev_attach" {
  user       = aws_iam_user.dev.name
  policy_arn = aws_iam_policy.eks_readonly.arn
}

###############################
# Map IAM User → Kubernetes RBAC
###############################

#resource "kubernetes_config_map" "aws_auth" {
#  metadata {
#   name      = "aws-auth"
#    namespace = "kube-system"
#  }

#  data = {
#    mapRoles = yamlencode([])
#    mapUsers = yamlencode([
#      {
#        userarn  = aws_iam_user.dev.arn
#        username = "innovatemart-dev"
#        groups   = ["read-only-group"]
#      }
#    ])
#  }
#}

###############################
# Kubernetes RoleBinding for Read-Only Group
###############################

resource "kubernetes_cluster_role_binding" "dev_view" {
  metadata {
    name = "dev-readonly-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }

  subject {
    kind      = "Group"
    name      = "read-only-group"
    api_group = "rbac.authorization.k8s.io"
  }
}
