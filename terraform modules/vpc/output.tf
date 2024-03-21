output "Cluster_Pri_Subnet" {
    value = [aws_subnet.privatesubnet1.id,aws_subnet.privatesubnet2.id]
  
}