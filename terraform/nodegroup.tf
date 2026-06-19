resource "aws_eks_node_group" "main" {

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "letstype-nodegroup"

  node_role_arn = aws_iam_role.nodegroup_role.arn

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  scaling_config {

    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  capacity_type = "ON_DEMAND"

  instance_types = [
    "t2.micro"
  ]

depends_on = [
  aws_iam_role_policy_attachment.worker_node_policy,
  aws_iam_role_policy_attachment.cni_policy,
  aws_iam_role_policy_attachment.ecr_readonly
]
}