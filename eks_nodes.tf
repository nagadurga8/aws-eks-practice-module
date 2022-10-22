resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks-cluster-node-role.arn
  instance_types  = var.instance_types
  ami_type        = var.ami_type
  subnet_ids      = aws_subnet.eks-public-subnets[*].id

  scaling_config {
    desired_size = var.desired_number_of_nodes
    max_size     = var.max_number_of_nodes
    min_size     = var.min_number_of_nodes
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

