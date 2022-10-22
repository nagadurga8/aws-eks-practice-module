output "ec2_instance_ip" {
  value = aws_instance.eks-servers.*.public_ip
}

output "ec2_instance_dns" {
  value = aws_instance.eks-servers.*.public_dns
}

output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}