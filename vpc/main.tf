resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "privatesubnet1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.Privatesubnet1_cidr
  availability_zone = var.availability_zoneA
  tags = {
    Name = var.privatesubnet1name
  }
}

resource "aws_subnet" "privatesubnet2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.Privatesubnet2_cidr
  availability_zone = var.availability_zoneB
  tags = {
    Name = var.privatesubnet1name
  }
}


resource "aws_subnet" "publicsubnet1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.publicsubnet1_cidr
  availability_zone = var.availability_zoneA

  tags = {
    Name = var.publicsubnet1name
  }
}
resource "aws_subnet" "publicsubnet2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.publicsubnet2_cidr
  availability_zone = var.availability_zoneB

  tags = {
    Name = var.publicsubnet2name
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_gateway_name
  }
}

resource "aws_route_table" "publicroutetable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.publicroutetablename
  }
}
resource "aws_route_table_association" "publicroutetable_association_1" {
  subnet_id = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.publicroutetable.id
}

resource "aws_route_table_association" "publicroutetable_association_2" {
  subnet_id = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.publicroutetable.id
}




resource "aws_eip" "nat-gateway-eip" {
  depends_on = [ aws_route_table.publicroutetable ]
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat-gateway-eip.id
  subnet_id = aws_subnet.publicsubnet1.id
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = var.nat_gateway_name
  }
}

resource "aws_route_table" "privateroutetable" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
}


resource "aws_route_table_association" "privateroutetable_association_1" {
  subnet_id = aws_subnet.privatesubnet1.id
  route_table_id = aws_route_table.privateroutetable.id
}

resource "aws_route_table_association" "privateroutetable_association_2" {
  subnet_id = aws_subnet.privatesubnet2.id
  route_table_id = aws_route_table.privateroutetable.id
}


resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol = "tcp"
    rule_no = 200
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
  }

  egress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
  }
  
  tags = {
    Name = var.public_acl
  }
}

resource "aws_network_acl_association" "publicnacl1" {
  network_acl_id = aws_network_acl.public_nacl.id
  subnet_id      = aws_subnet.publicsubnet1.id
}
resource "aws_network_acl_association" "publicnacl2" {
  network_acl_id = aws_network_acl.public_nacl.id
  subnet_id      = aws_subnet.publicsubnet2.id
}


resource "aws_network_acl" "private_nacl" {
  vpc_id = aws_vpc.main.id

  egress {
    protocol = "tcp"
    rule_no = 200
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
  }

  
  ingress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
  }

  tags = {
    Name = var.private_acl
  }
}
resource "aws_network_acl_association" "privatenacl1" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.privatesubnet1.id
}

resource "aws_network_acl_association" "privatenacl2" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.privatesubnet2.id
}


resource "aws_instance" "ec2_instance_name" {
ami = var.ami
instance_type = "var.instance_type"
subnet_id = aws_subnet.publicsubnet1.id
vpc_security_group_ids = [aws_security_group.allow_tls.id]
associate_public_ip_address = true
key_name = var.keyname
volume_tags = {
  volume_size = "var.volume_size"
}

tags = {
Name = "var.instance_name"
}

}

resource "aws_security_group" "allow_tls" {
  name        = "var.security_group_name"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
  

  tags = {
    Name = "var.security_group_name"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_1" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.MyIP
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_2" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.MyIP
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_3" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.MyIP
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



