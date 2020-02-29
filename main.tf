provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/multi-zone-infrastructure-with-ots"
}

locals {
  create_vpc         = var.use_existing_vpc ? false : var.create_vpc
  create_others      = var.use_existing_vpc || var.create_vpc
  this_vpc_id        = var.use_existing_vpc ? var.existing_vpc_id : module.vpc.this_vpc_id
  availability_zones = length(var.availability_zones) > 0 ? var.availability_zones : data.alicloud_zones.multi.zones.0.multi_zone_ids
}

data "alicloud_zones" "multi" {
  available_resource_creation = "Rds"
  multi                       = true
}

module "vpc" {
  source                  = "alibaba/vpc/alicloud"
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
  skip_region_validation  = var.skip_region_validation

  vpc_id          = var.existing_vpc_id
  create          = local.create_vpc
  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  vpc_description = "A vpc create by terraform module terraform-alicloud-multi-zone-infrastructure-with-ots"
  vpc_tags        = merge(var.vpc_tags, var.tags)

  vswitch_cidrs       = var.vswitch_cidrs
  availability_zones  = local.availability_zones
  use_num_suffix      = true
  vswitch_name        = var.vswitch_name
  vswitch_description = "A vswitch create by terraform module terraform-alicloud-multi-zone-infrastructure-with-ots"
  vswitch_tags        = merge(var.vswitch_tags, var.tags)
}

module "nat" {
  source                  = "terraform-alicloud-modules/nat-gateway/alicloud"
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
  skip_region_validation  = var.skip_region_validation

  ########################
  # New Nat gateway parameters
  ########################
  create               = var.create_nat
  vpc_id               = local.this_vpc_id
  name                 = var.nat_name
  specification        = var.nat_specification
  instance_charge_type = var.nat_instance_charge_type
  period               = var.nat_period
  description          = "A nat gateway create by terraform module terraform-alicloud-multi-zone-infrastructure-with-ots"

  ########################
  # New EIP parameters
  ########################
  create_eip               = var.create_eip
  number_of_eip            = var.number_of_eip
  eip_name                 = var.eip_name
  eip_bandwidth            = var.eip_bandwidth
  eip_internet_charge_type = var.eip_internet_charge_type
  eip_instance_charge_type = var.eip_instance_charge_type
  eip_period               = var.eip_period
  eip_tags                 = merge(var.eip_tags, var.tags)
}

module "snat" {
  source                  = "terraform-alicloud-modules/snat/alicloud"
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
  skip_region_validation  = var.skip_region_validation

  create        = true
  snat_table_id = module.nat.this_snat_table_id

  # Open for vswitch ids
  snat_with_vswitch_ids = [
    {
      vswitch_ids = concat(module.vpc.this_vswitch_ids, [""])[0]
      snat_ip     = concat(module.nat.this_eip_ips, [""])[0]
    },
    {
      vswitch_ids = concat(module.vpc.this_vswitch_ids, ["", ""])[1]
      snat_ip     = concat(module.nat.this_eip_ips, ["", ""])[1]
    }
  ]
}

module "security_group" {
  source                  = "alibaba/security-group/alicloud"
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
  skip_region_validation  = var.skip_region_validation

  # alicloud_security_group
  create      = var.create_security_group
  name        = var.security_group_name
  vpc_id      = local.this_vpc_id
  description = "A security group create by terraform module terraform-alicloud-multi-zone-infrastructure-with-ots"
  tags        = var.security_group_tags

  # alicloud_security_group_rule
  ingress_rules              = var.ingress_rules
  ingress_cidr_blocks        = var.ingress_cidr_blocks
  priority_for_ingress_rules = var.priority_for_ingress_rules
  default_ingress_priority   = var.default_ingress_priority

  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks

  # Ingress - Using a list of ports
  ingress_with_cidr_blocks_and_ports = var.ingress_with_cidr_blocks_and_ports
  ingress_ports                      = var.ingress_ports

  # Ingress - Maps of rules and each item with source_security_group_id
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id

  # Egress - List of rules (simple)
  egress_rules              = var.egress_rules
  egress_cidr_blocks        = var.egress_cidr_blocks
  priority_for_egress_rules = var.priority_for_egress_rules
  default_egress_priority   = var.default_egress_priority

  egress_with_cidr_blocks = var.egress_with_cidr_blocks

  # Egress - Using a list of ports
  egress_with_cidr_blocks_and_ports = var.egress_with_cidr_blocks_and_ports
  egress_ports                      = var.egress_ports

  # Egress - Maps of rules and each item with source_security_group_id
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
}

data "alicloud_instance_types" "zone_a" {
  cpu_core_count    = 1
  memory_size       = 2
  availability_zone = local.availability_zones[0]
}
data "alicloud_instance_types" "zone_b" {
  cpu_core_count = 1
  memory_size    = 2

  availability_zone = local.availability_zones[1]
}

module "ecs_zone_a" {
  source                  = "alibaba/ecs-instance/alicloud"
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
  skip_region_validation  = var.skip_region_validation

  # Ecs instance variables
  number_of_instances           = var.number_of_zone_a_instances
  use_num_suffix                = true
  image_id                      = var.ecs_image_id
  instance_type                 = var.ecs_instance_type == "" ? data.alicloud_instance_types.zone_a.ids.0 : var.ecs_instance_type
  credit_specification          = var.ecs_credit_specification
  security_group_ids            = [module.security_group.this_security_group_id]
  name                          = var.ecs_instance_name
  description                   = "An ECS instance create by terraform module terraform-alicloud-multi-zone-infrastructure-with-ots"
  resource_group_id             = var.resource_group_id
  host_name                     = var.ecs_host_name
  password                      = var.ecs_password
  system_disk_category          = var.ecs_system_disk_category
  system_disk_size              = var.ecs_system_disk_size
  data_disks                    = var.ecs_data_disks
  vswitch_id                    = concat(module.vpc.this_vswitch_ids, [""])[0]
  instance_charge_type          = var.ecs_instance_charge_type
  user_data                     = var.ecs_user_data
  role_name                     = var.ecs_role_name
  key_name                      = var.ecs_key_name
  spot_strategy                 = var.ecs_spot_strategy
  spot_price_limit              = var.ecs_spot_price_limit
  deletion_protection           = var.ecs_deletion_protection
  force_delete                  = true
  security_enhancement_strategy = var.ecs_security_enhancement_strategy
  subscription                  = var.ecs_subscription
  tags                          = merge(var.ecs_tags, var.tags)
  volume_tags                   = var.ecs_volume_tags
}

module "ecs_zone_b" {
  source                  = "alibaba/ecs-instance/alicloud"
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
  skip_region_validation  = var.skip_region_validation

  # Ecs instance variables
  number_of_instances           = var.number_of_zone_b_instances
  use_num_suffix                = true
  image_id                      = var.ecs_image_id
  instance_type                 = var.ecs_instance_type == "" ? data.alicloud_instance_types.zone_b.ids.0 : var.ecs_instance_type
  credit_specification          = var.ecs_credit_specification
  security_group_ids            = [module.security_group.this_security_group_id]
  name                          = var.ecs_instance_name
  description                   = "An ECS instance create by terraform module terraform-alicloud-multi-zone-infrastructure-with-ots"
  resource_group_id             = var.resource_group_id
  host_name                     = var.ecs_host_name
  password                      = var.ecs_password
  system_disk_category          = var.ecs_system_disk_category
  system_disk_size              = var.ecs_system_disk_size
  data_disks                    = var.ecs_data_disks
  vswitch_id                    = concat(module.vpc.this_vswitch_ids, [""])[1]
  instance_charge_type          = var.ecs_instance_charge_type
  user_data                     = var.ecs_user_data
  role_name                     = var.ecs_role_name
  key_name                      = var.ecs_key_name
  spot_strategy                 = var.ecs_spot_strategy
  spot_price_limit              = var.ecs_spot_price_limit
  deletion_protection           = var.ecs_deletion_protection
  force_delete                  = true
  security_enhancement_strategy = var.ecs_security_enhancement_strategy
  subscription                  = var.ecs_subscription
  tags                          = merge(var.ecs_tags, var.tags)
  volume_tags                   = var.ecs_volume_tags
}

module "slb" {
  source                  = "alibaba/slb/alicloud"
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
  skip_region_validation  = var.skip_region_validation

  create               = var.create_slb
  name                 = var.slb_name
  internet_charge_type = var.slb_internet_charge_type
  bandwidth            = var.slb_bandwidth
  spec                 = var.slb_spec
  tags                 = var.slb_tags
}

data "alicloud_db_instance_classes" "default" {
  engine         = var.rds_engine
  engine_version = var.rds_engine_version
  //  category       = "Basic"
  multi_zone = true
  //  storage_type   = var.rds_instance_storage_type
}

module "rds" {
  source                  = "terraform-alicloud-modules/rds/alicloud"
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
  skip_region_validation  = var.skip_region_validation

  create_instance        = var.create_rds_instance
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_name          = var.rds_instance_name
  instance_charge_type   = var.rds_instance_charge_type
  period                 = var.rds_period
  instance_storage       = var.rds_instance_storage
  instance_type          = var.rds_instance_type != "" ? var.rds_instance_type : data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  vpc_security_group_ids = var.rds_security_group_ids
  security_ips           = var.rds_security_ips
  tags                   = merge(var.rds_tags, var.tags)

  #################
  # Rds Backup policy
  #################
  preferred_backup_period     = var.rds_preferred_backup_period
  preferred_backup_time       = var.rds_preferred_backup_time
  backup_retention_period     = var.rds_backup_retention_period
  enable_backup_log           = var.rds_enable_backup_log
  log_backup_retention_period = var.rds_log_backup_retention_period

  #################
  # Rds Connection
  #################
  allocate_public_connection = var.rds_allocate_public_connection
  connection_prefix          = var.rds_connection_prefix
  port                       = var.rds_connection_port

  #################
  # Rds Database account
  #################
  create_account = var.create_rds_account
  account_name   = var.rds_account_name
  password       = var.rds_password
  type           = var.rds_account_type
  privilege      = var.rds_account_privilege

  #################
  # Rds Database
  #################
  create_database = var.create_rds_database
  databases       = var.rds_databases
}

module "ots" {
  source                  = "terraform-alicloud-modules/table-store/alicloud"
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
  skip_region_validation  = var.skip_region_validation

  create_instance = var.create_ots_instance
  instance_name   = var.ots_instance_name
  description     = "An OTS instance create by terraform module terraform-alicloud-multi-zone-infrastructure-with-ots"
  accessed_by     = var.ots_accessed_by
  instance_type   = var.ots_instance_type
  tags            = merge(var.ots_tags, var.tags)

  # table store instance attachment variables
  bind_vpc   = var.ots_instance_bind_vpc
  vswitch_id = concat(module.vpc.this_vswitch_ids, [""])[0]
  vpc_name   = "tfTable"

  # table variables
  create_table = var.create_ots_table
  table_name   = var.ots_table_name
  primary_key  = var.ots_table_primary_key
  time_to_live = var.ots_table_time_to_live
  max_version  = var.ots_table_max_version
}
