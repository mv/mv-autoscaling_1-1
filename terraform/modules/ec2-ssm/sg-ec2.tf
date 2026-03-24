locals {
  ingress = {
    ssh     = { from =   22, to=22   , protocol = "tcp"  , cidr = "0.0.0.0/0" }
    https   = { from =  443, to=443  , protocol = "tcp"  , cidr = "0.0.0.0/0" }
    ping    = { from =    8, to=0    , protocol = "icmp" , cidr = "0.0.0.0/0" } # echo_request: type=8, code=0
  }
  egress = {
    ssm     = { from =  443, to=443  , protocol = "tcp"  , cidr = "0.0.0.0/0" } # explicit
    all     = { from =    0, to=65535, protocol = "-1"   , cidr = "0.0.0.0/0" } # egress/all
  }
}

##
## My SG
##
resource "aws_security_group" "sg" {
  name        = "ec2-${var.name}"
  description = "EC2: ${var.name} security group"

  vpc_id = data.aws_subnet.subnet.vpc_id

  tags = merge(
    { Name = "ec2-${var.name}" },
    var.tags,
    local.module_tags
  )

}

##
## Ingress
##
resource "aws_security_group_rule" "ingress" {
  for_each = local.ingress

  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr]
  security_group_id = aws_security_group.sg.id
  description       = "From: ${each.value.cidr}, Rule: ${each.key}"
}

resource "aws_ec2_tag" "ingress" {
  for_each = local.ingress

  resource_id = aws_security_group_rule.ingress[each.key].security_group_rule_id
  key         = "Name"
  value       = "rule-ingress-${each.key}"
}

##
## Egress
##
resource "aws_security_group_rule" "egress" {
  for_each = local.egress

  type              = "egress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr]
  security_group_id = aws_security_group.sg.id
  description       = "From: ${each.value.cidr}, Rule: ${each.key}"
}

resource "aws_ec2_tag" "egress" {
  for_each = local.egress

  resource_id = aws_security_group_rule.egress[each.key].security_group_rule_id
  key         = "Name"
  value       = "rule-egress-${each.key}"
}