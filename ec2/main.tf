# modules/ec2_instances/main.tf


resource "aws_instance" "ec2" {
  count         = length(var.ami_ids)
  ami           = var.ami_ids[count.index]
  instance_type = var.instance_types[count.index]
  subnet_id     = var.subnet_ids[count.index]

  # Attach security groups
  security_groups = var.security_group_id

  tags = {
    Name = "Instance - ${count.index}"
  }
}