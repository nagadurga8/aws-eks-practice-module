resource "aws_instance" "eks-servers" {

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  monitoring             = false
  count                  = var.ec2_instances_count
  vpc_security_group_ids = [aws_default_security_group.eks-sg.id]
  subnet_id              = element(aws_subnet.eks-public-subnets.*.id, count.index)
  user_data              = file("user_data.sh")



  tags = {
    Name = "${var.ec2_instance_name}-${count.index + 1}"
  }
}
