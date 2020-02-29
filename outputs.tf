#################
# VPC
#################
output "this_vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.this_vpc_id
}

output "this_vpc_name" {
  description = "The VPC name"
  value       = module.vpc.this_vpc_name
}

output "this_vpc_tags" {
  description = "The tags of the VPC."
  value       = module.vpc.this_vpc_tags
}

output "this_vpc_cidr_block" {
  description = "The VPC cidr block."
  value       = module.vpc.this_vpc_cidr_block
}

#################
# Subnets
#################
output "this_vswitch_ids" {
  description = "List of IDs of vswitch."
  value       = module.vpc.this_vswitch_ids
}

output "this_availability_zones" {
  description = "List of availability zones in which vswitches launched."
  value       = module.vpc.this_availability_zones
}

output "this_vswitch_names" {
  description = "List names of vswitch."
  value       = module.vpc.this_vswitch_names
}

output "this_vswitch_tags" {
  description = "List tags of vswitch."
  value       = module.vpc.this_vswitch_tags
}

output "this_vswitch_cidr_blocks" {
  description = "List cidr blocks of vswitch."
  value       = module.vpc.this_vswitch_cidr_blocks
}

#################
# Security group
#################
output "this_security_group_id" {
  description = "The ID of the security group."
  value       = module.security_group.this_security_group_id
}

output "this_security_group_vpc_id" {
  description = "The VPC ID."
  value       = module.security_group.this_security_group_vpc_id
}

output "this_security_group_name" {
  description = "The name of the security group."
  value       = module.security_group.this_security_group_name
}

output "this_security_group_description" {
  description = "The description of the security group."
  value       = module.security_group.this_security_group_description
}

#################
# Ecs Instance
#################
output "this_ecs_zone_a_instance_ids" {
  description = "List IDs of the Ecs instance which in available zone a."
  value       = module.ecs_zone_a.this_instance_id
}

output "this_ecs_zone_a_instance_names" {
  description = "List names of the Ecs instance which in available zone a."
  value       = module.ecs_zone_a.this_instance_name
}
output "this_ecs_zone_a_instance_type" {
  description = "The Ecs instance type which in available zone a."
  value       = module.ecs_zone_a.this_instance_type
}
output "this_ecs_zone_a_instance_image_id" {
  description = "The Ecs instance image which in available zone a."
  value       = module.ecs_zone_a.this_image_id
}
output "this_ecs_zone_a_instance_private_ips" {
  description = "The Ecs instance private ips which in available zone a."
  value       = module.ecs_zone_a.this_private_ip
}
output "this_ecs_zone_a_instance_tags" {
  description = "The Ecs instance tags which in available zone a."
  value       = module.ecs_zone_a.this_instance_tags
}
output "this_ecs_zone_a_instance_host_names" {
  description = "The Ecs instance host names which in available zone a."
  value       = module.ecs_zone_a.this_host_name
}

output "this_ecs_zone_b_instance_ids" {
  description = "List IDs of the Ecs instance which in available zone a."
  value       = module.ecs_zone_a.this_instance_id
}

output "this_ecs_zone_b_instance_names" {
  description = "List names of the Ecs instance which in available zone a."
  value       = module.ecs_zone_a.this_instance_name
}
output "this_ecs_zone_b_instance_type" {
  description = "The Ecs instance type which in available zone a."
  value       = module.ecs_zone_a.this_instance_type
}
output "this_ecs_zone_b_instance_image_id" {
  description = "The Ecs instance image which in available zone a."
  value       = module.ecs_zone_a.this_image_id
}
output "this_ecs_zone_b_instance_private_ips" {
  description = "The Ecs instance private ips which in available zone a."
  value       = module.ecs_zone_a.this_private_ip
}
output "this_ecs_zone_b_instance_tags" {
  description = "The Ecs instance tags which in available zone a."
  value       = module.ecs_zone_a.this_instance_tags
}
output "this_ecs_zone_b_instance_host_names" {
  description = "The Ecs instance host names which in available zone a."
  value       = module.ecs_zone_a.this_host_name
}

#################
# Nat gateway
#################
output "this_nat_gateway_id" {
  description = "The nat gateway id."
  value       = module.nat.this_nat_gateway_id
}
output "this_dnat_table_id" {
  description = "The dnat table id in this nat gateway."
  value       = module.nat.this_dnat_table_id
}
output "this_snat_table_id" {
  description = "The snat table id in this nat gateway."
  value       = module.nat.this_snat_table_id
}
output "this_nat_gateway_name" {
  description = "The nat gateway name."
  value       = module.nat.this_nat_gateway_name
}
output "this_nat_gateway_spec" {
  description = "The nat gateway spec."
  value       = module.nat.this_nat_gateway_spec
}
output "this_nat_gateway_description" {
  description = "The nat gateway id."
  value       = module.nat.this_nat_gateway_description
}
output "this_nat_gateway_status" {
  description = "The nat gateway id."
  value       = module.nat.this_nat_gateway_status
}
#################
# EIP
#################
output "this_eip_ids" {
  description = "The id of new eips."
  value       = module.nat.this_eip_ids
}

output "this_eip_ips" {
  description = "The id of new eip addresses."
  value       = module.nat.this_eip_ips
}

#################
# SLB
#################
output "this_slb_id" {
  description = "The id of new slb."
  value       = module.slb.this_slb_id
}

output "this_slb_name" {
  description = "The name of new slb."
  value       = module.slb.this_slb_name
}

output "this_slb_ip_address" {
  description = "The ip address of new slb."
  value       = module.slb.this_slb_address
}
output "this_slb_tags" {
  description = "The tags of new slb."
  value       = module.slb.this_slb_tags
}

#################
# RDS outputs
#################
output "this_rds_instance_id" {
  description = "The id of rds instance."
  value       = module.rds.this_db_instance_id
}

output "this_rds_instance_name" {
  description = "The name of rds instance."
  value       = module.rds.this_db_instance_name
}

output "this_rds_instance_type" {
  description = "The instance type of rds instance."
  value       = module.rds.this_db_instance_type
}
output "this_rds_instance_tags" {
  description = "The tags of new rds instance."
  value       = module.rds.this_db_instance_tags
}

#################
# OTS outputs
#################
output "this_ots_instance_id" {
  description = "The id of ots instance."
  value       = module.rds.this_db_instance_id
}

output "this_ots_instance_name" {
  description = "The name of ots instance."
  value       = module.rds.this_db_instance_name
}
