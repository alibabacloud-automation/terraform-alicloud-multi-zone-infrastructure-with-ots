variable "region" {
  description = "(Deprecated from version 1.1.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 1.1.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "(Deprecated from version 1.1.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 1.1.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

#################
# VPC
#################
variable "create_vpc" {
  description = "Whether to create vpc. If false, you can specify an existing vpc by setting 'use_existing_vpc=true' and 'existing_vpc_id'."
  type        = bool
  default     = true
}

variable "existing_vpc_id" {
  description = "The vpc id used to launch several vswitches and other resources."
  type        = string
  default     = ""
}

variable "use_existing_vpc" {
  description = "The vpc id used to launch several vswitches. If set, the 'create_vpc' will be ignored."
  type        = bool
  default     = false
}

variable "vpc_name" {
  description = "The vpc name used to launch a new vpc."
  type        = string
  default     = "tf-multi-zone-infrastructure-with-ots"
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc."
  type        = string
  default     = "172.16.0.0/16"
}

variable "vpc_tags" {
  description = "The tags used to launch a new vpc."
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "The common tags will apply to all of resources."
  type        = map(string)
  default     = {}
}

#################
# Vswitch
#################
variable "vswitch_cidrs" {
  description = "List of cidr blocks used to launch several new vswitches. If not set, there is no new vswitches will be created."
  type        = list(string)
  default     = ["172.16.10.0/24", "172.16.20.0/24"]
}

variable "availability_zones" {
  description = "List available zones to launch several VSwitches and other resources. If not set, a list zones will be fetched and returned by data source."
  type        = list(string)
  default     = []
}

variable "vswitch_name" {
  description = "The vswitch name prefix used to launch several new vswitches."
  default     = "tf-multi-zone-infrastructure-with-ots"
}

variable "vswitch_tags" {
  description = "The tags used to launch serveral vswitches."
  type        = map(string)
  default     = {}
}

#################
# security-group
#################
variable "create_security_group" {
  description = "Whether to create security group."
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name of security group. It is used to create a new security group."
  type        = string
  default     = "tf-multi-zone-infrastructure-with-ots"
}

variable "security_group_tags" {
  description = "A mapping of tags to assign to security group."
  type        = map(string)
  default     = {}
}

#################
# ingress_rules
#################
variable "ingress_rules" {
  description = "List of ingress rules to create by name."
  type        = list(string)
  default     = []
}

variable "priority_for_ingress_rules" {
  description = "A priority is used when setting 'ingress_rules'. Default to 'default_ingress_priority'."
  type        = number
  default     = 1
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used. The valid keys contains 'cidr_blocks', 'from_port', 'to_port', 'protocol', 'description', 'priority' and 'rule'."
  type        = list(map(string))
  default     = []
}
variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where `source_security_group_id` is used."
  type        = list(map(string))
  default     = []
}

variable "ingress_with_cidr_blocks_and_ports" {
  description = "List of ingress rules to create where 'cidr_blocks' and 'ports' is used. The valid keys contains 'cidr_blocks', 'ports', 'protocol', 'description' and 'priority'. The ports item's 'from' and 'to' have the same port. Example: '80,443' means 80/80 and 443/443."
  type        = list(map(string))
  default     = []
}
variable "ingress_ports" {
  description = "The port list used on 'ingress_with_cidr_blocks_and_ports' ports rules."
  type        = list(number)
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "The IPv4 CIDR ranges list to use on ingress cidrs rules."
  type        = list(string)
  default     = []
}

variable "default_ingress_priority" {
  description = "A default ingress priority."
  type        = number
  default     = 50
}

#################
# egress_rules
#################
variable "egress_rules" {
  description = "List of egress rules to create by name."
  type        = list(string)
  default     = []
}
variable "priority_for_egress_rules" {
  description = "A priority where 'egress_rules' is used. Default to 'default_egress_priority'."
  type        = number
  default     = 1
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used. The valid keys contains 'cidr_blocks', 'from_port', 'to_port', 'protocol', 'description' and 'priority'."
  type        = list(map(string))
  default     = []
}

variable "egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used."
  type        = list(map(string))
  default     = []
}

variable "egress_with_cidr_blocks_and_ports" {
  description = "List of egress rules to create where 'cidr_blocks' and 'ports' is used. The valid keys contains 'cidr_blocks', 'ports', 'protocol', 'description' and 'priority'. The ports item's 'from' and 'to' have the same port. Example: '80,443' means 80/80 and 443/443."
  type        = list(map(string))
  default     = []
}
variable "egress_ports" {
  description = "The port list used on 'egress_with_cidr_blocks_and_ports' ports rules."
  type        = list(number)
  default     = []
}

variable "egress_cidr_blocks" {
  description = "The IPv4 CIDR ranges list to use on egress cidrs rules."
  type        = list(string)
  default     = []
}

variable "default_egress_priority" {
  description = "A default egress priority."
  type        = number
  default     = 50
}

########################
# New Ecs Instance parameters
########################
variable "number_of_zone_a_instances" {
  description = "The number of instances to be created."
  type        = number
  default     = 2
}
variable "number_of_zone_b_instances" {
  description = "The number of instances to be created."
  type        = number
  default     = 2
}

variable "ecs_image_id" {
  description = "The image id used to launch one or more ecs instances."
  type        = string
  default     = "ubuntu_18_04_x64_20G_alibase_20200220.vhd"
}

variable "ecs_instance_type" {
  description = "The instance type used to launch one or more ecs instances."
  type        = string
  default     = "ecs.sn1ne.large"
}

variable "ecs_credit_specification" {
  description = "Performance mode of the t5 burstable instance. Valid values: 'Standard', 'Unlimited'."
  type        = string
  default     = ""
}

variable "ecs_instance_name" {
  description = "Name to be used on all resources as prefix. Default to 'tf-multi-zone-infrastructure-with-ots'. The final default name would be tf-multi-zone-infrastructure-with-ots001, tf-multi-zone-infrastructure-with-ots002 and so on."
  type        = string
  default     = "tf-multi-zone-infrastructure-with-ots"
}

variable "resource_group_id" {
  description = "The Id of resource group which the instance belongs."
  type        = string
  default     = ""
}

variable "ecs_host_name" {
  description = "Host name used on all instances as prefix. Like if the value is TF-ECS-Host-Name and then the final host name would be TF-ECS-Host-Name001, TF-ECS-Host-Name002 and so on."
  type        = string
  default     = ""
}

variable "ecs_password" {
  description = "The password of instance."
  type        = string
  default     = ""
}

variable "ecs_system_disk_category" {
  description = "The system disk category used to launch one or more ecs instances."
  type        = string
  default     = "cloud_efficiency"
}

variable "ecs_system_disk_size" {
  description = "The system disk size used to launch one or more ecs instances."
  type        = number
  default     = 40
}

variable "ecs_data_disks" {
  description = "Additional data disks to attach to the scaled ECS instance"
  type        = list(map(string))
  default     = []
}

variable "ecs_instance_charge_type" {
  description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid'."
  type        = string
  default     = "PostPaid"
}

variable "ecs_user_data" {
  description = "User data to pass to instance on boot"
  type        = string
  default     = ""
}

variable "ecs_role_name" {
  description = "Instance RAM role name. The name is provided and maintained by RAM. You can use `alicloud_ram_role` to create a new one."
  type        = string
  default     = ""
}

variable "ecs_key_name" {
  description = "The name of SSH key pair that can login ECS instance successfully without password. If it is specified, the password would be invalid."
  type        = string
  default     = ""
}

variable "ecs_spot_strategy" {
  description = "The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter `instance_charge_type` is 'PostPaid'. Value range: 'NoSpot': A regular Pay-As-You-Go instance. 'SpotWithPriceLimit': A price threshold for a spot instance. 'SpotAsPriceGo': A price that is based on the highest Pay-As-You-Go instance"
  type        = string
  default     = "NoSpot"
}

variable "ecs_spot_price_limit" {
  description = "The hourly price threshold of a instance, and it takes effect only when parameter 'spot_strategy' is 'SpotWithPriceLimit'. Three decimals is allowed at most."
  type        = number
  default     = 0
}

variable "ecs_deletion_protection" {
  description = "Whether enable the deletion protection or not. 'true': Enable deletion protection. 'false': Disable deletion protection."
  type        = bool
  default     = false
}

variable "ecs_security_enhancement_strategy" {
  description = "The security enhancement strategy."
  type        = string
  default     = "Active"
}

variable "ecs_subscription" {
  description = "A mapping of fields for Prepaid ECS instances created. "
  type        = map(string)
  default = {
    period             = 1
    period_unit        = "Month"
    renewal_status     = "Normal"
    auto_renew_period  = 1
    include_data_disks = true
  }
}

variable "ecs_tags" {
  description = "A mapping of tags to assign to the ecs instances."
  type        = map(string)
  default     = {}
}

variable "ecs_volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time."
  type        = map(string)
  default     = {}
}
########################
# New Nat Gateway parameters
########################
variable "create_nat" {
  description = "Whether to create nat gateway."
  type        = bool
  default     = true
}

variable "nat_name" {
  description = "Name of a new nat gateway."
  type        = string
  default     = "tf-multi-zone-infrastructure-with-ots"
}

variable "nat_specification" {
  description = "The specification of nat gateway."
  type        = string
  default     = "Small"
}

variable "nat_instance_charge_type" {
  description = "The charge type of the nat gateway. Choices are 'PostPaid' and 'PrePaid'."
  type        = string
  default     = "PostPaid"
}

variable "nat_period" {
  description = "The charge duration of the PrePaid nat gateway, in month."
  type        = number
  default     = 1
}

########################
# New EIP parameters
########################
variable "create_eip" {
  description = "Whether to create new EIP and bind it to this Nat gateway."
  type        = bool
  default     = true
}
variable "number_of_eip" {
  description = "Number of EIP instance used to bind with this Nat gateway."
  type        = number
  default     = 2
}
variable "eip_name" {
  description = "Name to be used on all eip as prefix."
  type        = string
  default     = "tf-multi-zone-infrastructure-with-ots"
}

variable "eip_bandwidth" {
  description = "Maximum bandwidth to the elastic public network, measured in Mbps (Mega bit per second)."
  type        = number
  default     = 5
}

variable "eip_internet_charge_type" {
  description = "Internet charge type of the EIP, Valid values are `PayByBandwidth`, `PayByTraffic`. "
  type        = string
  default     = "PayByTraffic"
}

variable "eip_instance_charge_type" {
  description = "Elastic IP instance charge type."
  type        = string
  default     = "PostPaid"
}

variable "eip_period" {
  description = "The duration that you will buy the EIP, in month."
  type        = number
  default     = 1
}

variable "eip_tags" {
  description = "A mapping of tags to assign to the EIP instance resource."
  type        = map(string)
  default     = {}
}

########################
# New Load Balancer parameters
########################
variable "create_slb" {
  description = "Whether to create load balancer instance."
  type        = bool
  default     = true
}

variable "slb_name" {
  description = "The name of a new load balancer."
  type        = string
  default     = "tf-multi-zone-infrastructure-with-ots"
}

variable "slb_internet_charge_type" {
  description = "The charge type of load balancer instance internet network."
  type        = string
  default     = "PayByTraffic"
}

variable "slb_bandwidth" {
  description = "The load balancer instance bandwidth."
  type        = number
  default     = 10
}

variable "slb_spec" {
  description = "The specification of the SLB instance."
  type        = string
  default     = ""
}

variable "slb_tags" {
  description = "A mapping of tags to assign to the slb instances."
  type        = map(string)
  default     = {}
}

#################
# Rds Instance
#################
variable "create_rds_instance" {
  description = "Whether to create security group."
  type        = bool
  default     = true
}

variable "rds_engine" {
  description = "RDS Database type. Value options: MySQL, SQLServer, PostgreSQL, and PPAS"
  default     = "MySQL"
}

variable "rds_engine_version" {
  description = "RDS Database version. Value options can refer to the latest docs [CreateDBInstance](https://www.alibabacloud.com/help/doc-detail/26228.htm) `EngineVersion`"
  default     = "5.7"
}

variable "rds_instance_name" {
  description = "The name of DB instance."
  default     = "tf-multi-zone-infrastructure-with-ots"
}
variable "rds_instance_charge_type" {
  description = "The instance charge type. Valid values: Prepaid and Postpaid. Default to Postpaid."
  default     = "Postpaid"
}
variable "rds_period" {
  description = "The duration that you will buy DB instance (in month). It is valid when instance_charge_type is PrePaid. Valid values: [1~9], 12, 24, 36. Default to 1"
  type        = number
  default     = 1
}

variable "rds_instance_storage" {
  description = "The storage capacity of the instance. Unit: GB. The storage capacity increases at increments of 5 GB. For more information, see [Instance Types](https://www.alibabacloud.com/help/doc-detail/26312.htm)."
  type        = number
  default     = 20
}

variable "rds_instance_type" {
  description = "DB Instance type, for example: mysql.n1.micro.1. full list is : https://www.alibabacloud.com/help/zh/doc-detail/26312.htm"
  default     = ""
}

variable "rds_security_group_ids" {
  description = "List of VPC security group ids to associate with rds instance."
  type        = list(string)
  default     = []
}

variable "rds_security_ips" {
  description = " List of IP addresses allowed to access all databases of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32])."
  type        = list(string)
  default     = ["127.0.0.1"]
}
variable "rds_tags" {
  description = "A mapping of tags to assign to the rds instances."
  type        = map(string)
  default     = {}
}

#################
# Rds Backup policy
#################
variable "rds_preferred_backup_period" {
  description = "DB Instance backup period."
  type        = list(string)
  default     = []
}

variable "rds_preferred_backup_time" {
  description = " DB instance backup time, in the format of HH:mmZ- HH:mmZ. "
  type        = string
  default     = "02:00Z-03:00Z"
}

variable "rds_backup_retention_period" {
  description = "Instance backup retention days. Valid values: [7-730]. Default to 7."
  type        = number
  default     = 7
}

variable "rds_enable_backup_log" {
  description = "Whether to backup instance log. Default to true."
  type        = bool
  default     = true
}

variable "rds_log_backup_retention_period" {
  description = "Instance log backup retention days. Valid values: [7-730]. Default to 7. It can be larger than 'retention_period'."
  type        = number
  default     = 7
}

#################
# Rds Connection
#################
variable "rds_allocate_public_connection" {
  description = "Whether to allocate public connection for a RDS instance. If true, the connection_prefix can not be empty."
  type        = bool
  default     = false
}
variable "rds_connection_prefix" {
  description = "Prefix of an Internet connection string."
  type        = string
  default     = ""
}

variable "rds_connection_port" {
  description = " Internet connection port. Valid value: [3001-3999]. Default to 3306."
  type        = number
  default     = 3306
}

#################
# Rds Database account
#################
variable "create_rds_account" {
  description = "Whether to create a new account. If true, the 'rds_account_name' should not be empty."
  type        = bool
  default     = true
}
variable "rds_account_name" {
  description = "Name of a new database account. It should be set when create_rds_account = true."
  default     = ""
}
variable "rds_password" {
  description = "Operation database account password. It may consist of letters, digits, or underlines, with a length of 6 to 32 characters."
  default     = ""
}

variable "rds_account_type" {
  description = "Privilege type of account. Normal: Common privilege. Super: High privilege.Default to Normal."
  default     = "Normal"
}

variable "rds_account_privilege" {
  description = "The privilege of one account access database."
  default     = "ReadOnly"
}

#################
# Rds Database
#################
variable "create_rds_database" {
  description = "Whether to create multiple databases. If true, the `databases` should not be empty."
  type        = bool
  default     = true
}

variable "rds_databases" {
  description = "A list mapping used to add multiple databases. Each item supports keys: name, character_set and description. It should be set when create_database = true."
  type        = list(map(string))
  default     = []
}
#################
# Tablestore parameters
#################
variable "create_ots_instance" {
  description = "Whether to create ots instance. if true, a new ots instance will be created."
  type        = bool
  default     = true
}

variable "ots_instance_name" {
  description = "The name of the instance."
  type        = string
  default     = "tf-created-ots"
}

variable "ots_accessed_by" {
  description = "The network limitation of accessing instance. Valid values:[\"Any\", \"Vpc\", \"ConsoleOrVpc\"]."
  type        = string
  default     = "Any"
}

variable "ots_instance_type" {
  description = "The type of instance. Valid values: [\"Capacity\", \"HighPerformance\"]."
  type        = string
  default     = "HighPerformance"
}

variable "ots_tags" {
  description = "A mapping of tags to assign to the instance."
  type        = map(string)
  default     = {}
}


# table store instance attachment variables
variable "ots_instance_bind_vpc" {
  description = "Whether to create ots instance attachment. If true, the ots instance will be attached with vpc and vswitch."
  type        = bool
  default     = true
}

variable "create_ots_table" {
  description = "Whether to create ots table. If true, a new ots table will be created"
  type        = bool
  default     = false
}

variable "ots_table_name" {
  description = "(Required, ForceNew) The table name of the OTS instance. If changed, a new table would be created."
  type        = string
  default     = ""
}

variable "ots_table_primary_key" {
  description = "The property of TableMeta which indicates the structure information of a table. It describes the attribute value of primary key. The number of primary_key should not be less than one and not be more than four."
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "ots_table_time_to_live" {
  description = "The retention time of data stored in this table (unit: second). The value maximum is 2147483647 and -1 means never expired."
  type        = number
  default     = -1
}

variable "ots_table_max_version" {
  description = "The maximum number of versions stored in this table. The valid value is 1-2147483647."
  type        = number
  default     = 1
}
