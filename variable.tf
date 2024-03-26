#vpc variables
variable "vpc_cidr" {}

variable "public_subnet_cidr" {
  type = list(string)
}

variable "private_subnet_cidr" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}
#eks variables
variable cluster_role_name {
    type = string
  }
  variable cluster_name{
    type = string
  }

  variable workernode_rolename {
    type = string
  }
  variable nodegroup_name {
    type = string
  }
  variable workernode_type{
    type =list(string)
  }

  variable desired_node{
    type = string
  }
  variable max_node{
    type = string
  }
  variable min_node{
    type = string
  }
  #ec2 variables
variable "ami_ids" {
  type = list(string)
}

variable "instance_types" {
  type = list(string)
}




variable "domain_name" {
  type=string
}

variable "myIP" {
    type=string
  
}
variable "region" {
    type=string
  
}