variable cluster_rolename {
    type = string
  }
  variable cluster_name{
    type = string
  }
  variable cluster_subnetid {
  }
  variable workernode_role {
    type = string
  }
  variable nodegroup_name {
    type = string
  }
  variable workernode_type{
    type = list(string)
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
