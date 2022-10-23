resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_trust_role.arn

  vpc_config {
    security_group_ids = [aws_default_security_group.eks-sg.id]
    public_access_cidrs = ["0.0.0.0/0"]
    subnet_ids = aws_subnet.eks-public-subnets[*].id
    endpoint_private_access = true
    endpoint_public_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}

# SG created by EKS
data "aws_security_group" "eks_cluster_sg" {
  id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}

# SG Rule which you would like to add
resource "aws_security_group_rule" "rule-1" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = data.aws_security_group.eks_cluster_sg.id
}