output "output_cluster_privatesubnet" {
    value = [aws_subnet.private_subnet[0].id,aws_subnet.private_subnet[1].id]
}
output "output_instancesubnet" {
    value = [aws_subnet.public_subnet[0].id]
  
}
output "output_vpc_id" {
  value = aws_vpc.vpc.id
}