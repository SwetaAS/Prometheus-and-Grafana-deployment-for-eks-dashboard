resource "aws_security_group" "security_group" {
  vpc_id      = var.ref_vpcid
 

tags = {
    Name = var.securitygroup_name
  }
 
}

resource "aws_security_group_rule" "securitygroup_rule" {
 
  for_each = var.securitygroup_rules
 
  type              = each.value.type
  security_group_id = aws_security_group .security_group.id
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
}