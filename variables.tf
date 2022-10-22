#----------------------------------------------------------------
#                       EKS Variables                           #
#----------------------------------------------------------------

variable "eks_cluster_name" {
  description = "Provide the eks cluster name"
}

variable "node_group_name" {
  description = "Provide the eks cluster node group name"
}

variable "instance_types" {
  description = "Provide ami type for node group"
}

variable "ami_type" {
  description = "provide the ami type for eks cluster"
}

variable "desired_number_of_nodes" {
  description = "provide the value for ec2 instance desired count"
}

variable "max_number_of_nodes" {
  description = "provide the value for ec2 instance maximum count"
}

variable "min_number_of_nodes" {
  description = "provide the value for ec2 instance minimum count"
}

#----------------------------------------------------------------
#                       VPC Variables                           #
#----------------------------------------------------------------

variable "cidr_block" {
  description = "VPC CIDR block information"
}

variable "vpc_name" {
  description = "Provide the VPC name"
}

variable "availability_zone" {
  description = "provide list of availability zones for subnets creation"
}

variable "public_subnet_cidr_blocks" {
  description = "provide the subnet CIDR's"
}

variable "public_subnet_name" {
  description = "provide the public subnet name"
}

#----------------------------------------------------------------
#                       EC2 Variables                           #
#----------------------------------------------------------------

variable "ec2_instance_name" {
  description = "provide the ec2 instance name"
}

variable "ami_id" {
  description = "Provide the AMI id for ec2 instance"
}

variable "instance_type" {
  description = "Provide the ec2 instance type"
}

variable "key_pair_name" {
  description = "Provide the key pair name to login into ec2 instance"
}
