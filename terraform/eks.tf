resource "aws_eks_cluster" "main" {

  name     = "letstype-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn

  version = "1.33"

  access_config {
  authentication_mode = "API_AND_CONFIG_MAP"
  bootstrap_cluster_creator_admin_permissions = true
}

  vpc_config {

    subnet_ids = [
      aws_subnet.private_a.id,
      aws_subnet.private_b.id,
      aws_subnet.public_a.id,
      aws_subnet.public_b.id
    ]

    security_group_ids = [
      aws_security_group.eks_sg.id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

