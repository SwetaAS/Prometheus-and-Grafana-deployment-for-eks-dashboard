vpc_cidr = "192.168.0.0/16"
public_subnet_cidr = ["192.168.3.0/24","192.168.4.0/24"]
private_subnet_cidr = ["192.168.1.0/24","192.168.2.0/24"]
availability_zones = ["us-east-1a","us-east-1b"]

region ="us-east-1"

ami_ids =["ami-0cd59ecaf368e5ccf",]
instance_types =["t2.medium",]

myIP = "49.207.186.65/32"


cluster_role_name = "mycluster_role"
cluster_name ="mycluster1"
workernode_rolename ="workernode_role"
nodegroup_name1 = "nodegroup_1"
workernode_type = ["t2.micro",]
desired_node = "1"
max_node = "2"
min_node = "1"

#cluster_subnets = ["192.168.1.0/24","192.168.2.0/24"]



