variable "vpc_cidr" {
  
   description = "id for VPC"
   type = string
   
}
variable "vpc_name"{
    description = "value for vpc"
    type = string
    
}

variable "availability_zoneA" {
  description = "value for zone-1"
  type = string
  
}

variable "availability_zoneB" {
  
}
variable "Privatesubnet1_cidr" {
   description = "id for private subnet1"
    
    type = string
    
}

variable "privatesubnet1name" {
   description = "value for private subnet1 "
    
    type = string
    
  
}
variable "Privatesubnet2_cidr" {
    description = "id for private subnet2"
    
    type = string
    
}

variable "privatesubnet2name" {
    description = "value for private subnet2 "
    
    type = string
    
  
}


variable "publicsubnet1_cidr" {
  description = "id for publicsubnet1"
  type = string
  
}

variable "publicsubnet1name" {
    description = "value for publicsubnet1"
    type = string
    
  
}
variable "publicsubnet2_cidr" {
  description = "id for publicsubnet2"
  type = string
  
}

variable "publicsubnet2name" {
    description = "value for publicsubnet2"
    type = string
    
  
}


variable "igw_gateway_name" {
    description = "value for igw"
    type = string
    
}

variable "nat_gateway_name" {
    description = "value for nat gateway"
    type = string
    
}
variable "publicroutetablename" {
    description = "value for public route table"
    type = string
    
  
}

variable "privateroutetablename" {
    description = "value for private route table"
    type = string
    
  
}
variable "public_acl" {
    description = "value for public acl"
    type = string
   
}

variable "private_acl" {
    description = "value for private acl"
    type = string
    
}

variable "instance_name"{
    description = "value for instance name"
    type = string
}

variable "keyname"{
    type = string
}

variable "instance_type"{
    description = "value for instance type"
    type = string
}

variable "volume_size"{
    description = "value for instance size"
    type = string
}

variable "security_group_name"{
    description = "value for security group"
    type = string

}


variable "ami" {
  
   type        = string
  
  
}

variable "MyIP"{
    type = string
}

#eks

variable cluster_rolename {
    type = string
  }
  variable cluster_name{
    type = string
  }

  variable workernode_role {
    type = string
  }
  variable nodegroup_name {
    type = string
  }
  variable workernode_type{
  }

  variable desirednode_size{
    type = string
  }
  variable max_node_size{
    type = string
  }
  variable min_node_size {
    type = string
  }




 