resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_trust_role.arn

  vpc_config {
    subnet_ids = aws_subnet.eks-public-subnets[*].id
    endpoint_private_access = true
    endpoint_public_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}
