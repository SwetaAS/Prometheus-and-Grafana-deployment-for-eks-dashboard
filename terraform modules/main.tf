terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}



 
module "Network" {
  source = "./vpc"
  vpc_name = var.vpc_name
  vpc_cidr= var.vpc_cidr

  availability_zoneA = var.availability_zoneA
  availability_zoneB = var.availability_zoneB
  
  privatesubnet1name = var.Privatesubnet1_cidr
  privatesubnet2name = var.Privatesubnet2_cidr
  
  publicsubnet1name = var.publicsubnet1name
  publicsubnet2name = var.publicsubnet2name
  
 Privatesubnet1_cidr = var.privatesubnet1name
 Privatesubnet2_cidr = var.privatesubnet2name
 
 publicsubnet1_cidr = var.publicsubnet1_cidr
 publicsubnet2_cidr = var.publicsubnet2_cidr
 
 publicroutetablename = var.publicroutetablename
 privateroutetablename = var.privateroutetablename
 
 igw_gateway_name = var.igw_gateway_name
 nat_gateway_name = var.nat_gateway_name
 
 public_acl = var.public_acl
 private_acl = var.private_acl
 keyname = var.keyname
 ami = var.ami
  volume_size =var.volume_size
  instance_type = var.volume_size
  instance_name = var.instance_name
  security_group_name = var.security_group_name
  MyIP = var.MyIP
  
}


module "eks_module" {
  source = "./eks"
  cluster_subnetid = module.Network.Cluster_Pri_Subnet
  cluster_rolename = var.cluster_rolename
  cluster_name = var.cluster_name
  workernode_role = var.workernode_role
  nodegroup_name   = var.nodegroup_name 
  workernode_type = var.workernode_type
  desirednode_size = var.desirednode_size
  max_node_size = var.max_node_size
  min_node_size = var.min_node_size
}
 