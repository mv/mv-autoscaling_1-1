
##
## LB
##

output "id"         { value = module.nlb.id }
#utput "arn"        { value = module.nlb.arn }
#utput "arn_suffix" { value = module.nlb.arn_suffix }
output "dns_name"   { value = module.nlb.dns_name }
output "zone_id"    { value = module.nlb.zone_id }

#utput "listeners"      { value = module.nlb.listeners }
#utput "listener_rules" { value = module.nlb.listener_rules }
#utput "target_groups"  { value = module.nlb.target_groups }

#utput "security_group_arn" { value = module.nlb.security_group_arn }
output "security_group_id"  { value = module.nlb.security_group_id }

#utput "route53_records"    { value = module.nlb.route53_records }
