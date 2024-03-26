variable cluster_role_name {
    type = string
  }
  variable cluster_name{
    type = string
  }
  variable cluster_subnets{
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