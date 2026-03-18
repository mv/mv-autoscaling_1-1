
##
## LB
##

#utput "nlb_arn"        { value = module.nlb.arn }
#utput "nlb_arn_suffix" { value = module.nlb.arn_suffix }
output "nlb_dns_name"   { value = module.nlb.dns_name }
output "nlb_id"         { value = module.nlb.id }
output "nlb_sg_id"      { value = module.nlb.security_group_id }
output "nlb_zone_id"    { value = module.nlb.zone_id }

# output "listeners_all"  { value = module.nlb.listeners }
# output "listeners_keys" {
#   value = [
#     for k in keys(module.nlb.listeners): k
#   ]
# }
output "listeners_data" {
  value = {
    for k in keys(module.nlb.listeners):
      k => tomap({
        "protocol"  = module.nlb.listeners[k].protocol
        "port"      = module.nlb.listeners[k].port
      })
  }
}

output "listener_rules_all" { value = module.nlb.listener_rules }


#utput "target_groups_all"  { value = module.nlb.target_groups }
#utput "target_groups_keys" { value = [ for k in keys(module.nlb.target_groups): k ] }
output "target_groups_data" {
  value = {
    for k in keys(module.nlb.target_groups):
      k => tomap({
        "arn"             = module.nlb.target_groups[k].arn
        "health_check_0"  = module.nlb.target_groups[k].health_check[0].enabled
        "ip_address_type" = module.nlb.target_groups[k].ip_address_type
        "name"            = module.nlb.target_groups[k].name
        "port"            = module.nlb.target_groups[k].port
        "protocol"        = module.nlb.target_groups[k].protocol
        "target_type"     = module.nlb.target_groups[k].target_type
      })
  }
}


#utput "route53_records_all" { value = module.nlb.route53_records }
