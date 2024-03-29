

module "vpc" {
    source = "./modules/vpc"
    vpc_cidr =var.vpc_cidr
    public_subnet_cidr =var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    availability_zones = var.availability_zones
  
}
module "eks" {
    source = "./modules/eks"

    cluster_role_name = var.cluster_role_name
    cluster_name = var.cluster_name
    cluster_subnets = module.vpc.output_cluster_private_subnet
    workernode_rolename  = var.workernode_rolename 
    nodegroup_name1 =var.nodegroup_name1
    workernode_type =var.workernode_type
    desired_node = var.desired_node
    max_node =var.max_node
    min_node = var.min_node
    eks_security_group_id =module.ekssecurity_group.output_security_id
   # cluster_subnets = var.cluster_id
    
    
}
module "ec2" {
    source = "./modules/ec2"
    ami_ids =var.ami_ids
    instance_types = var.instance_types
    subnet_ids = module.vpc.output_instancesubnet
    security_group_id = module.security_group.output_security_id
  
}

module "security_group" {
    source = "./modules/securitygroup"
    ref_vpcid =module.vpc.output_vpc_id
    securitygroup_name = "Ec2-security-group"
 
securitygroup_rules = {
    ssh = {
      type              ="ingress"
      from_port         = 22
      to_port           = 22
      protocol          = "tcp"
      cidr_blocks       = [var.myIP]
    
    }
    http = {
      type              ="ingress"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      cidr_blocks       = [var.myIP]
    }
 
    https = {
      type              ="ingress"
      from_port         = 443
      to_port           = 443
      protocol          = "tcp"
      cidr_blocks       = [var.myIP]
    }
    icmp = {
      type              ="ingress"
      from_port         = -1
      to_port           = -1
      protocol          = "icmp"
      cidr_blocks       = ["0.0.0.0/0",]
    }
 
      all_egress = {
      type              ="egress"
      from_port         = 0
      to_port           = 0
      protocol          = "-1"
      cidr_blocks       = ["0.0.0.0/0"]
    }
}
}


module "ekssecurity_group" {
  source = "./modules/securitygroup"
    ref_vpcid =module.vpc.output_vpc_id
    securitygroup_name = "Ec2-security-group"
 
securitygroup_rules = {
    ssh = {
      type              ="ingress"
      from_port         = 22
      to_port           = 22
      protocol          = "tcp"
      cidr_blocks       = [var.myIP]
    
    }
    http = {
      type              ="ingress"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      cidr_blocks       = [var.myIP]
    }
 
    https = {
      type              ="ingress"
      from_port         = 443
      to_port           = 443
      protocol          = "tcp"
      cidr_blocks       = [var.myIP]
    }
    icmp = {
      type              ="ingress"
      from_port         = -1
      to_port           = -1
      protocol          = "icmp"
      cidr_blocks       = ["0.0.0.0/0",]
    }
 
      all_egress = {
      type              ="egress"
      from_port         = 0
      to_port           = 0
      protocol          = "-1"
      cidr_blocks       = ["0.0.0.0/0"]
    }
}
}


