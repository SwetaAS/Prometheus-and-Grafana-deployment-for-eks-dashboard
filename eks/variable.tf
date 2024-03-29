variable cluster_role_name {
    type = string
  }
  variable cluster_name{
    type = string
  }
  variable cluster_subnets{
    type = list(string)
    
  }
  variable workernode_rolename {
    type = string
  }
  variable nodegroup_name1 {
    type = string
    default = null
  }
  variable workernode_type{
    type = list(string)
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
  
variable "eks_security_group_id" {
 
}
# variable "cluster_id"{
#   type = list(string)
# }
