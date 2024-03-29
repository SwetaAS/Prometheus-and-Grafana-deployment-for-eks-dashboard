variable "ref_vpcid" {
  
}
variable "securitygroup_name" {
  type = string
}
variable "securitygroup_rules" {
  type = map(any)
}