
vpc_name = "main_vpc"
vpc_cidr = "192.168.0.0/16"

availability_zoneA = "us-east-1a"
availability_zoneB = "us-east-1b"

  
privatesubnet1name = "Private_subnet1-AZ1"
privatesubnet2name = "Private_subnet2-AZ2"
  
publicsubnet1name = "Public_subnet1-AZ1"
publicsubnet2name = "Public_subnet2-AZ2"
  
Privatesubnet1_cidr = "192.168.1.0/24"
Privatesubnet2_cidr = "192.168.2.0/24"
 
publicsubnet1_cidr = "192.168.3.0/24"
publicsubnet2_cidr = "192.168.4.0/24"
 
publicroutetablename = "Public route table"
privateroutetablename = "Private route table"
 
 igw_gateway_name = "igw_gateway"
 nat_gateway_name = "nat_gateway"
 
 public_acl = "Public acl"
 private_acl = "Private acl"

ami = ""
volume_size =   "8GiB"
instance_name = "Ansible_instance"
instance_type = "t2.medium"
MyIP = "49.207.186.165/32"
security_group_name = "ec2_securitygroup"
keyname = " "


  cluster_rolename = "mycluster1_role"
  cluster_name = "mycluster1"
  workernode_role = "Nodegroup1role"
  nodegroup_name   = "Nodegroup1"
  workernode_type = "t2.micro"
  desirednode_size = "1"
  max_node_size = "2"
  min_node_size = "1"


