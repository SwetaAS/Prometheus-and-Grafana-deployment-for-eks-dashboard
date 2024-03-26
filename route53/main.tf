resource "aws_route53_zone" "route53" {
  name = var.domain_name
}

resource "aws_acm_certificate" "cert" {
  domain_name       =  var.domain_name
  validation_method = "DNS"
}