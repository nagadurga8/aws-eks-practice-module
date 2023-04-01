# aws-eks-practice-module

## AWS EKS Cluster Creation

To create an AWS EKS cluster for practice purpose, please use below module

```hcl
module "aws_eks" {
    source = "git::https://github.com/nagadurga8/aws-eks-practice-module.git?ref=1.0.0"

    eks_cluster_name = "petclinic_eks_cluster"
    node_group_name  = "petclinic_eks_cluster_node_group"
    instance_types   = ["t2.micro"]
    ami_type         = "AL2_x86_64"
    desired_number_of_nodes = "2"
    max_number_of_nodes = "2"
    min_number_of_nodes = "2"

    cidr_block                = "10.50.0.0/16"
    vpc_name                  = "eks_cluster_vpc"
    availability_zone         = ["us-east-1a", "us-east-1b", "us-east-1c"]
    public_subnet_cidr_blocks = ["10.50.0.0/17", "10.50.128.0/17"]
    public_subnet_name        = "eks_cluster_subnets"

    ec2_instance_name   = "petclinic_eks_login_instance"
    ami_id              = "ami-007855ac798b5175e"
    instance_type       = "t2.medium"
    key_pair_name       = "newkeypair"

}
```
## Inputs for EKS Cluster

| Key | Value |
| ------ | ------ |
| eks_cluster_name | Name of the eks cluster |
| node_group_name | Name of the node group |
| instance_types | Instance types used in node group to deploy the nodes |
| ami_type | AMI type which will be used to deploy the nodes] |
| desired_number_of_nodes | Number of nodes requierd to run all the time |
| max_number_of_nodes | Maximum number of nodes in the node group |
| min_number_of_nodes | Mimimum number of nodes in the node group |

## Inputs for VPC Creation

| Key | Value |
| ------ | ------ |
| cidr_block | IP address range to create VPC |
| vpc_name | Name of the VPC |
| availability_zone | Availability Zones information to create subnets |
| public_subnet_cidr_blocks | Subnets IP range to create the subnets |
| public_subnet_name | Name of the subnet |

## Inputs for EC2 Instance Creation

| Key | Value |
| ------ | ------ |
| ec2_instance_name | Name of the ec2 instance |
| ami_id | AMI id to create ec2 instance |
| instance_type | Instance type to create the ec2 instance |
| key_pair_name | key pair name to ssh into ec2 instance |


If you are facing any issues while deploying the pods, it might be the issue with CPU & Memory of the cluster

In this case, change the instane types to t2.medium in the module

```sh
From instance_types = ["t2.micro"] to instance_types = ["t2.medium"]
```

If required, increase the number of nodes as well.


To see the outputs of ec2 instance follow the below instructions.

1. Create a file called outputs.tf
2. Copy the below content into outputs.tf

```hcl
output "instance_dns_name" {
  value = module.aws_eks.ec2_instance_dns
}

output "instance_ip" {
  value = module.aws_eks.ec2_instance_ip
}

output "endpoint" {
  value = module.aws_eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = module.aws_eks.kubeconfig-certificate-authority-data
}
```
## Once EKS Cluster is deployed, run the below command to access the cluster

```hcl
aws eks update-kubeconfig --region <region-code> --name <cluster-name>
```

