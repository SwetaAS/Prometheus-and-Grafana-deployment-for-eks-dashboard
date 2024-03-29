 #iam for cluster

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cluster_role" {
  name               = var.cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster_role.name
}

#cluster
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = var.cluster_subnets
     endpoint_private_access = true
    endpoint_public_access  = false
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}


# Managed Node Group Roles (worker nodes )

resource "aws_iam_role" "workernode_role" {
  name = var.workernode_rolename
 
  assume_role_policy = jsonencode({
   Statement = [{
    Action = "sts:AssumeRole"
    Effect = "Allow"
    Principal = {
     Service = "ec2.amazonaws.com"
    }
   }]
   Version = "2012-10-17"
  })
 }
 
 resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role    = aws_iam_role.workernode_role.name
 }
 
 resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role    = aws_iam_role.workernode_role.name
 }
 
 resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role    = aws_iam_role.workernode_role.name
 }
 
 resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role    = aws_iam_role.workernode_role.name
 }


 # Managed node group
  resource "aws_eks_node_group" "workernodegroup" {
    cluster_name  = aws_eks_cluster.cluster.name
    node_group_name = var.nodegroup_name1
    node_role_arn  = aws_iam_role.workernode_role.arn
    subnet_ids   = var.cluster_subnets
    instance_types         = var.workernode_type
    #   launch_template {
    #   id = aws_launch_template.eks_launch_template.id
    #   version = "$Default"
    # }


 
    scaling_config {
      desired_size = var.desired_node
      max_size   = var.max_node
      min_size   = var.min_node
    }
  
    depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy]
    #aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    #aws_launch_template.eks_launch_template  
  }
 

#  resource "aws_launch_template" "eks_launch_template" {
#   name_prefix             = "node-"
#   description             = "Launch template for EKS nodes"
#   instance_type          = var.workernode_type  
#   key_name                = "ekskey"  
#   # iam_instance_profile {
#   #   arn = aws_iam_role.workernode_role.arn
#   # }
#  security_group_names    = ["eks-security-group"]
#   image_id            = var.eks_ami_id

#   network_interfaces {
#     security_groups =  var.eks_security_group_id
#   }
  
#   monitoring {
#     enabled = true
#   }
# }


 