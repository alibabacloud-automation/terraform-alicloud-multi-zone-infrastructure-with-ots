Building a multi-zone infrastructure which including ECS, SLB, RDS and OTS on Alibaba Cloud.    
terraform-alicloud-multi-zone-infrastructure-with-ots
=================

Terraform module which create an infrastructure which including several resources, like VPC, VSwitch, Security Group, ECS Instances, SLB, EIP, Nat Gateway, Rds and Tablestore on Alibaba Cloud.

These types of resources are supported:

* [VPC](https://www.terraform.io/docs/providers/alicloud/r/vpc.html)
* [VSwitch](https://www.terraform.io/docs/providers/alicloud/r/vswitch.html)
* [ECS-VPC Security Group](https://www.terraform.io/docs/providers/alicloud/r/security_group.html)
* [ECS-VPC Security Group Rule](https://www.terraform.io/docs/providers/alicloud/r/security_group_rule.html)
* [Nat Gateway](https://www.terraform.io/docs/providers/alicloud/r/nat_gateway.html)
* [Eip](https://www.terraform.io/docs/providers/alicloud/r/eip.html)
* [Eip_association](https://www.terraform.io/docs/providers/alicloud/r/eip_association.html)
* [Slb Instance](https://www.terraform.io/docs/providers/alicloud/r/slb.html)
* [Snat Entry](https://www.terraform.io/docs/providers/alicloud/r/snat.html)
* [Rds Instance](https://www.terraform.io/docs/providers/alicloud/r/db_instance.html)
* [Rds Account](https://www.terraform.io/docs/providers/alicloud/r/db_account.html)
* [Rds Database](https://www.terraform.io/docs/providers/alicloud/r/db_database.html)
* [Rds Backup Policy](https://www.terraform.io/docs/providers/alicloud/r/db_backup_policy.html)
* [OTS Instance](https://github.com/terraform-providers/terraform-provider-alicloud/blob/master/website/docs/r/ots_instance.html.markdown)
* [OTS Instance_Attachment](https://github.com/terraform-providers/terraform-provider-alicloud/blob/master/website/docs/r/ots_instance_attachment.html.markdown)
* [OTS Table](https://github.com/terraform-providers/terraform-provider-alicloud/blob/master/website/docs/r/ots_table.html.markdown)


## Usage

Create both VPC and Security group.

```hcl
module "infrastructure" {
  source  = "terraform-alicloud-modules/multi-zone-infrastructure-with-ots/alicloud"

  # create vpc and vswitch resources
  create_vpc    = true
  vpc_name      = "my-env-vpc"
  vpc_cidr      = "10.10.0.0/16"
  vswitch_cidrs = ["10.10.1.0/24", "10.10.2.0/24"]

  # create new security group
  create_security_group = true
  security_group_name   = "new-sg"
  ingress_cidr_blocks   = ["10.10.0.0/16"]
  ingress_rules         = ["https-443-tcp"]

  # create ecs instances in the two zone
  number_of_zone_a_instances = 2
  number_of_zone_b_instances = 2
  ecs_instance_type          = "ecs.sn1ne.large"

  # create a new nat gateway and several eips
  create_nat        = true
  nat_specification = "Small"
  create_eip        = true
  number_of_eip     = 2

  # create slb
  create_slb    = true
  slb_bandwidth = 10
  slb_spec      = "slb.s1.small"

  # create rds instance
  create_rds_instance = true
  rds_engine          = "MySQL"
  rds_engine_version  = "5.7"
  rds_account_name    = "tfexamplename"
  rds_password        = "Example1234"
  rds_databases = [
    {
      name          = "tf_example_db"
      character_set = "utf8"
      description   = "tf-example"
    }
  ]

  # create table store
  create_ots_instance = true
  ots_instance_name   = "main-ots"
  create_ots_table    = true
  ots_table_name      = "tf_ots_table"
  ots_table_primary_key = [
    {
      name = "pk1"
      type = "Integer"
    },
    {
      name = "pk2"
      type = "Integer"
    },
  ]
}
```

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/multi-zone-infrastructure-with-ots"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

```hcl
module "infrastructure" {
  source     = "terraform-alicloud-modules/multi-zone-infrastructure-with-ots/alicloud"
  version    = "1.0.0"
  region     = "cn-hangzhou"
  profile    = "Your-Profile-Name"
  create_vpc = true
  vpc_name   = "my-env-vpc"
  // ...
}
```

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
}
module "infrastructure" {
  source     = "terraform-alicloud-modules/multi-zone-infrastructure-with-ots/alicloud"
  create_vpc = true
  vpc_name   = "my-env-vpc"
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  alias   = "hz"
}
module "infrastructure" {
  source     = "terraform-alicloud-modules/multi-zone-infrastructure-with-ots/alicloud"
  providers  = {
    alicloud = alicloud.hz
  }
  create_vpc = true
  vpc_name   = "my-env-vpc"
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs_zone_a"></a> [ecs\_zone\_a](#module\_ecs\_zone\_a) | alibaba/ecs-instance/alicloud | 2.12.0 |
| <a name="module_ecs_zone_b"></a> [ecs\_zone\_b](#module\_ecs\_zone\_b) | alibaba/ecs-instance/alicloud | 2.12.0 |
| <a name="module_nat"></a> [nat](#module\_nat) | terraform-alicloud-modules/nat-gateway/alicloud | 1.5.0 |
| <a name="module_ots"></a> [ots](#module\_ots) | terraform-alicloud-modules/table-store/alicloud | 1.2.0 |
| <a name="module_rds"></a> [rds](#module\_rds) | terraform-alicloud-modules/rds/alicloud | 2.5.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | alibaba/security-group/alicloud | 2.4.0 |
| <a name="module_slb"></a> [slb](#module\_slb) | alibaba/slb/alicloud | 2.1.0 |
| <a name="module_snat"></a> [snat](#module\_snat) | terraform-alicloud-modules/snat/alicloud | 2.2.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | alibaba/vpc/alicloud | 1.11.0 |

## Resources

| Name | Type |
|------|------|
| [alicloud_db_instance_classes.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_instance_types.zone_a](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_instance_types.zone_b](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.multi](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List available zones to launch several VSwitches and other resources. If not set, a list zones will be fetched and returned by data source. | `list(string)` | `[]` | no |
| <a name="input_create_eip"></a> [create\_eip](#input\_create\_eip) | Whether to create new EIP and bind it to this Nat gateway. | `bool` | `true` | no |
| <a name="input_create_nat"></a> [create\_nat](#input\_create\_nat) | Whether to create nat gateway. | `bool` | `true` | no |
| <a name="input_create_ots_instance"></a> [create\_ots\_instance](#input\_create\_ots\_instance) | Whether to create ots instance. if true, a new ots instance will be created. | `bool` | `true` | no |
| <a name="input_create_ots_table"></a> [create\_ots\_table](#input\_create\_ots\_table) | Whether to create ots table. If true, a new ots table will be created | `bool` | `false` | no |
| <a name="input_create_rds_account"></a> [create\_rds\_account](#input\_create\_rds\_account) | Whether to create a new account. If true, the 'rds\_account\_name' should not be empty. | `bool` | `true` | no |
| <a name="input_create_rds_database"></a> [create\_rds\_database](#input\_create\_rds\_database) | Whether to create multiple databases. If true, the `databases` should not be empty. | `bool` | `true` | no |
| <a name="input_create_rds_instance"></a> [create\_rds\_instance](#input\_create\_rds\_instance) | Whether to create security group. | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create security group. | `bool` | `true` | no |
| <a name="input_create_slb"></a> [create\_slb](#input\_create\_slb) | Whether to create load balancer instance. | `bool` | `true` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Whether to create vpc. If false, you can specify an existing vpc by setting 'use\_existing\_vpc=true' and 'existing\_vpc\_id'. | `bool` | `true` | no |
| <a name="input_default_egress_priority"></a> [default\_egress\_priority](#input\_default\_egress\_priority) | A default egress priority. | `number` | `50` | no |
| <a name="input_default_ingress_priority"></a> [default\_ingress\_priority](#input\_default\_ingress\_priority) | A default ingress priority. | `number` | `50` | no |
| <a name="input_ecs_credit_specification"></a> [ecs\_credit\_specification](#input\_ecs\_credit\_specification) | Performance mode of the t5 burstable instance. Valid values: 'Standard', 'Unlimited'. | `string` | `""` | no |
| <a name="input_ecs_data_disks"></a> [ecs\_data\_disks](#input\_ecs\_data\_disks) | Additional data disks to attach to the scaled ECS instance | `list(map(string))` | `[]` | no |
| <a name="input_ecs_deletion_protection"></a> [ecs\_deletion\_protection](#input\_ecs\_deletion\_protection) | Whether enable the deletion protection or not. 'true': Enable deletion protection. 'false': Disable deletion protection. | `bool` | `false` | no |
| <a name="input_ecs_host_name"></a> [ecs\_host\_name](#input\_ecs\_host\_name) | Host name used on all instances as prefix. Like if the value is TF-ECS-Host-Name and then the final host name would be TF-ECS-Host-Name001, TF-ECS-Host-Name002 and so on. | `string` | `""` | no |
| <a name="input_ecs_image_id"></a> [ecs\_image\_id](#input\_ecs\_image\_id) | The image id used to launch one or more ecs instances. | `string` | `"ubuntu_18_04_x64_20G_alibase_20200220.vhd"` | no |
| <a name="input_ecs_instance_charge_type"></a> [ecs\_instance\_charge\_type](#input\_ecs\_instance\_charge\_type) | The charge type of instance. Choices are 'PostPaid' and 'PrePaid'. | `string` | `"PostPaid"` | no |
| <a name="input_ecs_instance_name"></a> [ecs\_instance\_name](#input\_ecs\_instance\_name) | Name to be used on all resources as prefix. Default to 'tf-multi-zone-infrastructure-with-ots'. The final default name would be tf-multi-zone-infrastructure-with-ots001, tf-multi-zone-infrastructure-with-ots002 and so on. | `string` | `"tf-multi-zone-infrastructure-with-ots"` | no |
| <a name="input_ecs_instance_type"></a> [ecs\_instance\_type](#input\_ecs\_instance\_type) | The instance type used to launch one or more ecs instances. | `string` | `"ecs.sn1ne.large"` | no |
| <a name="input_ecs_key_name"></a> [ecs\_key\_name](#input\_ecs\_key\_name) | The name of SSH key pair that can login ECS instance successfully without password. If it is specified, the password would be invalid. | `string` | `""` | no |
| <a name="input_ecs_password"></a> [ecs\_password](#input\_ecs\_password) | The password of instance. | `string` | `""` | no |
| <a name="input_ecs_role_name"></a> [ecs\_role\_name](#input\_ecs\_role\_name) | Instance RAM role name. The name is provided and maintained by RAM. You can use `alicloud_ram_role` to create a new one. | `string` | `""` | no |
| <a name="input_ecs_security_enhancement_strategy"></a> [ecs\_security\_enhancement\_strategy](#input\_ecs\_security\_enhancement\_strategy) | The security enhancement strategy. | `string` | `"Active"` | no |
| <a name="input_ecs_spot_price_limit"></a> [ecs\_spot\_price\_limit](#input\_ecs\_spot\_price\_limit) | The hourly price threshold of a instance, and it takes effect only when parameter 'spot\_strategy' is 'SpotWithPriceLimit'. Three decimals is allowed at most. | `number` | `0` | no |
| <a name="input_ecs_spot_strategy"></a> [ecs\_spot\_strategy](#input\_ecs\_spot\_strategy) | The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter `instance_charge_type` is 'PostPaid'. Value range: 'NoSpot': A regular Pay-As-You-Go instance. 'SpotWithPriceLimit': A price threshold for a spot instance. 'SpotAsPriceGo': A price that is based on the highest Pay-As-You-Go instance | `string` | `"NoSpot"` | no |
| <a name="input_ecs_subscription"></a> [ecs\_subscription](#input\_ecs\_subscription) | A mapping of fields for Prepaid ECS instances created. | `map(string)` | <pre>{<br>  "auto_renew_period": 1,<br>  "include_data_disks": true,<br>  "period": 1,<br>  "period_unit": "Month",<br>  "renewal_status": "Normal"<br>}</pre> | no |
| <a name="input_ecs_system_disk_category"></a> [ecs\_system\_disk\_category](#input\_ecs\_system\_disk\_category) | The system disk category used to launch one or more ecs instances. | `string` | `"cloud_efficiency"` | no |
| <a name="input_ecs_system_disk_size"></a> [ecs\_system\_disk\_size](#input\_ecs\_system\_disk\_size) | The system disk size used to launch one or more ecs instances. | `number` | `40` | no |
| <a name="input_ecs_tags"></a> [ecs\_tags](#input\_ecs\_tags) | A mapping of tags to assign to the ecs instances. | `map(string)` | `{}` | no |
| <a name="input_ecs_user_data"></a> [ecs\_user\_data](#input\_ecs\_user\_data) | User data to pass to instance on boot | `string` | `""` | no |
| <a name="input_ecs_volume_tags"></a> [ecs\_volume\_tags](#input\_ecs\_volume\_tags) | A mapping of tags to assign to the devices created by the instance at launch time. | `map(string)` | `{}` | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | The IPv4 CIDR ranges list to use on egress cidrs rules. | `list(string)` | `[]` | no |
| <a name="input_egress_ports"></a> [egress\_ports](#input\_egress\_ports) | The port list used on 'egress\_with\_cidr\_blocks\_and\_ports' ports rules. | `list(number)` | `[]` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of egress rules to create by name. | `list(string)` | `[]` | no |
| <a name="input_egress_with_cidr_blocks"></a> [egress\_with\_cidr\_blocks](#input\_egress\_with\_cidr\_blocks) | List of egress rules to create where 'cidr\_blocks' is used. The valid keys contains 'cidr\_blocks', 'from\_port', 'to\_port', 'protocol', 'description' and 'priority'. | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_cidr_blocks_and_ports"></a> [egress\_with\_cidr\_blocks\_and\_ports](#input\_egress\_with\_cidr\_blocks\_and\_ports) | List of egress rules to create where 'cidr\_blocks' and 'ports' is used. The valid keys contains 'cidr\_blocks', 'ports', 'protocol', 'description' and 'priority'. The ports item's 'from' and 'to' have the same port. Example: '80,443' means 80/80 and 443/443. | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_source_security_group_id"></a> [egress\_with\_source\_security\_group\_id](#input\_egress\_with\_source\_security\_group\_id) | List of egress rules to create where 'source\_security\_group\_id' is used. | `list(map(string))` | `[]` | no |
| <a name="input_eip_bandwidth"></a> [eip\_bandwidth](#input\_eip\_bandwidth) | Maximum bandwidth to the elastic public network, measured in Mbps (Mega bit per second). | `number` | `5` | no |
| <a name="input_eip_instance_charge_type"></a> [eip\_instance\_charge\_type](#input\_eip\_instance\_charge\_type) | Elastic IP instance charge type. | `string` | `"PostPaid"` | no |
| <a name="input_eip_internet_charge_type"></a> [eip\_internet\_charge\_type](#input\_eip\_internet\_charge\_type) | Internet charge type of the EIP, Valid values are `PayByBandwidth`, `PayByTraffic`. | `string` | `"PayByTraffic"` | no |
| <a name="input_eip_name"></a> [eip\_name](#input\_eip\_name) | Name to be used on all eip as prefix. | `string` | `"tf-multi-zone-infrastructure-with-ots"` | no |
| <a name="input_eip_period"></a> [eip\_period](#input\_eip\_period) | The duration that you will buy the EIP, in month. | `number` | `1` | no |
| <a name="input_eip_tags"></a> [eip\_tags](#input\_eip\_tags) | A mapping of tags to assign to the EIP instance resource. | `map(string)` | `{}` | no |
| <a name="input_existing_vpc_id"></a> [existing\_vpc\_id](#input\_existing\_vpc\_id) | The vpc id used to launch several vswitches and other resources. | `string` | `""` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | The IPv4 CIDR ranges list to use on ingress cidrs rules. | `list(string)` | `[]` | no |
| <a name="input_ingress_ports"></a> [ingress\_ports](#input\_ingress\_ports) | The port list used on 'ingress\_with\_cidr\_blocks\_and\_ports' ports rules. | `list(number)` | `[]` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules to create by name. | `list(string)` | `[]` | no |
| <a name="input_ingress_with_cidr_blocks"></a> [ingress\_with\_cidr\_blocks](#input\_ingress\_with\_cidr\_blocks) | List of ingress rules to create where 'cidr\_blocks' is used. The valid keys contains 'cidr\_blocks', 'from\_port', 'to\_port', 'protocol', 'description', 'priority' and 'rule'. | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_cidr_blocks_and_ports"></a> [ingress\_with\_cidr\_blocks\_and\_ports](#input\_ingress\_with\_cidr\_blocks\_and\_ports) | List of ingress rules to create where 'cidr\_blocks' and 'ports' is used. The valid keys contains 'cidr\_blocks', 'ports', 'protocol', 'description' and 'priority'. The ports item's 'from' and 'to' have the same port. Example: '80,443' means 80/80 and 443/443. | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_source_security_group_id"></a> [ingress\_with\_source\_security\_group\_id](#input\_ingress\_with\_source\_security\_group\_id) | List of ingress rules to create where `source_security_group_id` is used. | `list(map(string))` | `[]` | no |
| <a name="input_nat_instance_charge_type"></a> [nat\_instance\_charge\_type](#input\_nat\_instance\_charge\_type) | The charge type of the nat gateway. Choices are 'PostPaid' and 'PrePaid'. | `string` | `"PostPaid"` | no |
| <a name="input_nat_name"></a> [nat\_name](#input\_nat\_name) | Name of a new nat gateway. | `string` | `"tf-multi-zone-infrastructure-with-ots"` | no |
| <a name="input_nat_period"></a> [nat\_period](#input\_nat\_period) | The charge duration of the PrePaid nat gateway, in month. | `number` | `1` | no |
| <a name="input_nat_specification"></a> [nat\_specification](#input\_nat\_specification) | The specification of nat gateway. | `string` | `"Small"` | no |
| <a name="input_number_of_eip"></a> [number\_of\_eip](#input\_number\_of\_eip) | Number of EIP instance used to bind with this Nat gateway. | `number` | `2` | no |
| <a name="input_number_of_zone_a_instances"></a> [number\_of\_zone\_a\_instances](#input\_number\_of\_zone\_a\_instances) | The number of instances to be created. | `number` | `2` | no |
| <a name="input_number_of_zone_b_instances"></a> [number\_of\_zone\_b\_instances](#input\_number\_of\_zone\_b\_instances) | The number of instances to be created. | `number` | `2` | no |
| <a name="input_ots_accessed_by"></a> [ots\_accessed\_by](#input\_ots\_accessed\_by) | The network limitation of accessing instance. Valid values:["Any", "Vpc", "ConsoleOrVpc"]. | `string` | `"Any"` | no |
| <a name="input_ots_instance_bind_vpc"></a> [ots\_instance\_bind\_vpc](#input\_ots\_instance\_bind\_vpc) | Whether to create ots instance attachment. If true, the ots instance will be attached with vpc and vswitch. | `bool` | `true` | no |
| <a name="input_ots_instance_name"></a> [ots\_instance\_name](#input\_ots\_instance\_name) | The name of the instance. | `string` | `"tf-created-ots"` | no |
| <a name="input_ots_instance_type"></a> [ots\_instance\_type](#input\_ots\_instance\_type) | The type of instance. Valid values: ["Capacity", "HighPerformance"]. | `string` | `"HighPerformance"` | no |
| <a name="input_ots_table_max_version"></a> [ots\_table\_max\_version](#input\_ots\_table\_max\_version) | The maximum number of versions stored in this table. The valid value is 1-2147483647. | `number` | `1` | no |
| <a name="input_ots_table_name"></a> [ots\_table\_name](#input\_ots\_table\_name) | (Required, ForceNew) The table name of the OTS instance. If changed, a new table would be created. | `string` | `""` | no |
| <a name="input_ots_table_primary_key"></a> [ots\_table\_primary\_key](#input\_ots\_table\_primary\_key) | The property of TableMeta which indicates the structure information of a table. It describes the attribute value of primary key. The number of primary\_key should not be less than one and not be more than four. | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | `[]` | no |
| <a name="input_ots_table_time_to_live"></a> [ots\_table\_time\_to\_live](#input\_ots\_table\_time\_to\_live) | The retention time of data stored in this table (unit: second). The value maximum is 2147483647 and -1 means never expired. | `number` | `-1` | no |
| <a name="input_ots_tags"></a> [ots\_tags](#input\_ots\_tags) | A mapping of tags to assign to the instance. | `map(string)` | `{}` | no |
| <a name="input_priority_for_egress_rules"></a> [priority\_for\_egress\_rules](#input\_priority\_for\_egress\_rules) | A priority where 'egress\_rules' is used. Default to 'default\_egress\_priority'. | `number` | `1` | no |
| <a name="input_priority_for_ingress_rules"></a> [priority\_for\_ingress\_rules](#input\_priority\_for\_ingress\_rules) | A priority is used when setting 'ingress\_rules'. Default to 'default\_ingress\_priority'. | `number` | `1` | no |
| <a name="input_rds_account_name"></a> [rds\_account\_name](#input\_rds\_account\_name) | Name of a new database account. It should be set when create\_rds\_account = true. | `string` | `""` | no |
| <a name="input_rds_account_privilege"></a> [rds\_account\_privilege](#input\_rds\_account\_privilege) | The privilege of one account access database. | `string` | `"ReadOnly"` | no |
| <a name="input_rds_account_type"></a> [rds\_account\_type](#input\_rds\_account\_type) | Privilege type of account. Normal: Common privilege. Super: High privilege.Default to Normal. | `string` | `"Normal"` | no |
| <a name="input_rds_allocate_public_connection"></a> [rds\_allocate\_public\_connection](#input\_rds\_allocate\_public\_connection) | Whether to allocate public connection for a RDS instance. If true, the connection\_prefix can not be empty. | `bool` | `false` | no |
| <a name="input_rds_backup_retention_period"></a> [rds\_backup\_retention\_period](#input\_rds\_backup\_retention\_period) | Instance backup retention days. Valid values: [7-730]. Default to 7. | `number` | `7` | no |
| <a name="input_rds_connection_port"></a> [rds\_connection\_port](#input\_rds\_connection\_port) | Internet connection port. Valid value: [3001-3999]. Default to 3306. | `number` | `3306` | no |
| <a name="input_rds_connection_prefix"></a> [rds\_connection\_prefix](#input\_rds\_connection\_prefix) | Prefix of an Internet connection string. | `string` | `""` | no |
| <a name="input_rds_databases"></a> [rds\_databases](#input\_rds\_databases) | A list mapping used to add multiple databases. Each item supports keys: name, character\_set and description. It should be set when create\_database = true. | `list(map(string))` | `[]` | no |
| <a name="input_rds_enable_backup_log"></a> [rds\_enable\_backup\_log](#input\_rds\_enable\_backup\_log) | Whether to backup instance log. Default to true. | `bool` | `true` | no |
| <a name="input_rds_engine"></a> [rds\_engine](#input\_rds\_engine) | RDS Database type. Value options: MySQL, SQLServer, PostgreSQL, and PPAS | `string` | `"MySQL"` | no |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | RDS Database version. Value options can refer to the latest docs [CreateDBInstance](https://www.alibabacloud.com/help/doc-detail/26228.htm) `EngineVersion` | `string` | `"5.7"` | no |
| <a name="input_rds_instance_charge_type"></a> [rds\_instance\_charge\_type](#input\_rds\_instance\_charge\_type) | The instance charge type. Valid values: Prepaid and Postpaid. Default to Postpaid. | `string` | `"Postpaid"` | no |
| <a name="input_rds_instance_name"></a> [rds\_instance\_name](#input\_rds\_instance\_name) | The name of DB instance. | `string` | `"tf-multi-zone-infrastructure-with-ots"` | no |
| <a name="input_rds_instance_storage"></a> [rds\_instance\_storage](#input\_rds\_instance\_storage) | The storage capacity of the instance. Unit: GB. The storage capacity increases at increments of 5 GB. For more information, see [Instance Types](https://www.alibabacloud.com/help/doc-detail/26312.htm). | `number` | `20` | no |
| <a name="input_rds_instance_type"></a> [rds\_instance\_type](#input\_rds\_instance\_type) | DB Instance type, for example: mysql.n1.micro.1. full list is : https://www.alibabacloud.com/help/zh/doc-detail/26312.htm | `string` | `""` | no |
| <a name="input_rds_log_backup_retention_period"></a> [rds\_log\_backup\_retention\_period](#input\_rds\_log\_backup\_retention\_period) | Instance log backup retention days. Valid values: [7-730]. Default to 7. It can be larger than 'retention\_period'. | `number` | `7` | no |
| <a name="input_rds_password"></a> [rds\_password](#input\_rds\_password) | Operation database account password. It may consist of letters, digits, or underlines, with a length of 6 to 32 characters. | `string` | `""` | no |
| <a name="input_rds_period"></a> [rds\_period](#input\_rds\_period) | The duration that you will buy DB instance (in month). It is valid when instance\_charge\_type is PrePaid. Valid values: [1~9], 12, 24, 36. Default to 1 | `number` | `1` | no |
| <a name="input_rds_preferred_backup_period"></a> [rds\_preferred\_backup\_period](#input\_rds\_preferred\_backup\_period) | DB Instance backup period. | `list(string)` | `[]` | no |
| <a name="input_rds_preferred_backup_time"></a> [rds\_preferred\_backup\_time](#input\_rds\_preferred\_backup\_time) | DB instance backup time, in the format of HH:mmZ- HH:mmZ. | `string` | `"02:00Z-03:00Z"` | no |
| <a name="input_rds_security_group_ids"></a> [rds\_security\_group\_ids](#input\_rds\_security\_group\_ids) | List of VPC security group ids to associate with rds instance. | `list(string)` | `[]` | no |
| <a name="input_rds_security_ips"></a> [rds\_security\_ips](#input\_rds\_security\_ips) | List of IP addresses allowed to access all databases of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32]). | `list(string)` | <pre>[<br>  "127.0.0.1"<br>]</pre> | no |
| <a name="input_rds_tags"></a> [rds\_tags](#input\_rds\_tags) | A mapping of tags to assign to the rds instances. | `map(string)` | `{}` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The Id of resource group which the instance belongs. | `string` | `""` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of security group. It is used to create a new security group. | `string` | `"tf-multi-zone-infrastructure-with-ots"` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | A mapping of tags to assign to security group. | `map(string)` | `{}` | no |
| <a name="input_slb_bandwidth"></a> [slb\_bandwidth](#input\_slb\_bandwidth) | The load balancer instance bandwidth. | `number` | `10` | no |
| <a name="input_slb_internet_charge_type"></a> [slb\_internet\_charge\_type](#input\_slb\_internet\_charge\_type) | The charge type of load balancer instance internet network. | `string` | `"PayByTraffic"` | no |
| <a name="input_slb_name"></a> [slb\_name](#input\_slb\_name) | The name of a new load balancer. | `string` | `"tf-multi-zone-infrastructure-with-ots"` | no |
| <a name="input_slb_spec"></a> [slb\_spec](#input\_slb\_spec) | The specification of the SLB instance. | `string` | `""` | no |
| <a name="input_slb_tags"></a> [slb\_tags](#input\_slb\_tags) | A mapping of tags to assign to the slb instances. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The common tags will apply to all of resources. | `map(string)` | `{}` | no |
| <a name="input_use_existing_vpc"></a> [use\_existing\_vpc](#input\_use\_existing\_vpc) | The vpc id used to launch several vswitches. If set, the 'create\_vpc' will be ignored. | `bool` | `false` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The cidr block used to launch a new vpc. | `string` | `"172.16.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The vpc name used to launch a new vpc. | `string` | `"tf-multi-zone-infrastructure-with-ots"` | no |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | The tags used to launch a new vpc. | `map(string)` | `{}` | no |
| <a name="input_vswitch_cidrs"></a> [vswitch\_cidrs](#input\_vswitch\_cidrs) | List of cidr blocks used to launch several new vswitches. If not set, there is no new vswitches will be created. | `list(string)` | <pre>[<br>  "172.16.10.0/24",<br>  "172.16.20.0/24"<br>]</pre> | no |
| <a name="input_vswitch_name"></a> [vswitch\_name](#input\_vswitch\_name) | The vswitch name prefix used to launch several new vswitches. | `string` | `"tf-multi-zone-infrastructure-with-ots"` | no |
| <a name="input_vswitch_tags"></a> [vswitch\_tags](#input\_vswitch\_tags) | The tags used to launch serveral vswitches. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_availability_zones"></a> [this\_availability\_zones](#output\_this\_availability\_zones) | List of availability zones in which vswitches launched. |
| <a name="output_this_dnat_table_id"></a> [this\_dnat\_table\_id](#output\_this\_dnat\_table\_id) | The dnat table id in this nat gateway. |
| <a name="output_this_ecs_zone_a_instance_host_names"></a> [this\_ecs\_zone\_a\_instance\_host\_names](#output\_this\_ecs\_zone\_a\_instance\_host\_names) | The Ecs instance host names which in available zone a. |
| <a name="output_this_ecs_zone_a_instance_ids"></a> [this\_ecs\_zone\_a\_instance\_ids](#output\_this\_ecs\_zone\_a\_instance\_ids) | List IDs of the Ecs instance which in available zone a. |
| <a name="output_this_ecs_zone_a_instance_image_id"></a> [this\_ecs\_zone\_a\_instance\_image\_id](#output\_this\_ecs\_zone\_a\_instance\_image\_id) | The Ecs instance image which in available zone a. |
| <a name="output_this_ecs_zone_a_instance_names"></a> [this\_ecs\_zone\_a\_instance\_names](#output\_this\_ecs\_zone\_a\_instance\_names) | List names of the Ecs instance which in available zone a. |
| <a name="output_this_ecs_zone_a_instance_private_ips"></a> [this\_ecs\_zone\_a\_instance\_private\_ips](#output\_this\_ecs\_zone\_a\_instance\_private\_ips) | The Ecs instance private ips which in available zone a. |
| <a name="output_this_ecs_zone_a_instance_tags"></a> [this\_ecs\_zone\_a\_instance\_tags](#output\_this\_ecs\_zone\_a\_instance\_tags) | The Ecs instance tags which in available zone a. |
| <a name="output_this_ecs_zone_a_instance_type"></a> [this\_ecs\_zone\_a\_instance\_type](#output\_this\_ecs\_zone\_a\_instance\_type) | The Ecs instance type which in available zone a. |
| <a name="output_this_ecs_zone_b_instance_host_names"></a> [this\_ecs\_zone\_b\_instance\_host\_names](#output\_this\_ecs\_zone\_b\_instance\_host\_names) | The Ecs instance host names which in available zone a. |
| <a name="output_this_ecs_zone_b_instance_ids"></a> [this\_ecs\_zone\_b\_instance\_ids](#output\_this\_ecs\_zone\_b\_instance\_ids) | List IDs of the Ecs instance which in available zone a. |
| <a name="output_this_ecs_zone_b_instance_image_id"></a> [this\_ecs\_zone\_b\_instance\_image\_id](#output\_this\_ecs\_zone\_b\_instance\_image\_id) | The Ecs instance image which in available zone a. |
| <a name="output_this_ecs_zone_b_instance_names"></a> [this\_ecs\_zone\_b\_instance\_names](#output\_this\_ecs\_zone\_b\_instance\_names) | List names of the Ecs instance which in available zone a. |
| <a name="output_this_ecs_zone_b_instance_private_ips"></a> [this\_ecs\_zone\_b\_instance\_private\_ips](#output\_this\_ecs\_zone\_b\_instance\_private\_ips) | The Ecs instance private ips which in available zone a. |
| <a name="output_this_ecs_zone_b_instance_tags"></a> [this\_ecs\_zone\_b\_instance\_tags](#output\_this\_ecs\_zone\_b\_instance\_tags) | The Ecs instance tags which in available zone a. |
| <a name="output_this_ecs_zone_b_instance_type"></a> [this\_ecs\_zone\_b\_instance\_type](#output\_this\_ecs\_zone\_b\_instance\_type) | The Ecs instance type which in available zone a. |
| <a name="output_this_eip_ids"></a> [this\_eip\_ids](#output\_this\_eip\_ids) | The id of new eips. |
| <a name="output_this_eip_ips"></a> [this\_eip\_ips](#output\_this\_eip\_ips) | The id of new eip addresses. |
| <a name="output_this_nat_gateway_description"></a> [this\_nat\_gateway\_description](#output\_this\_nat\_gateway\_description) | The nat gateway id. |
| <a name="output_this_nat_gateway_id"></a> [this\_nat\_gateway\_id](#output\_this\_nat\_gateway\_id) | The nat gateway id. |
| <a name="output_this_nat_gateway_name"></a> [this\_nat\_gateway\_name](#output\_this\_nat\_gateway\_name) | The nat gateway name. |
| <a name="output_this_nat_gateway_spec"></a> [this\_nat\_gateway\_spec](#output\_this\_nat\_gateway\_spec) | The nat gateway spec. |
| <a name="output_this_nat_gateway_status"></a> [this\_nat\_gateway\_status](#output\_this\_nat\_gateway\_status) | The nat gateway id. |
| <a name="output_this_ots_instance_id"></a> [this\_ots\_instance\_id](#output\_this\_ots\_instance\_id) | The id of ots instance. |
| <a name="output_this_ots_instance_name"></a> [this\_ots\_instance\_name](#output\_this\_ots\_instance\_name) | The name of ots instance. |
| <a name="output_this_rds_instance_id"></a> [this\_rds\_instance\_id](#output\_this\_rds\_instance\_id) | The id of rds instance. |
| <a name="output_this_rds_instance_name"></a> [this\_rds\_instance\_name](#output\_this\_rds\_instance\_name) | The name of rds instance. |
| <a name="output_this_rds_instance_tags"></a> [this\_rds\_instance\_tags](#output\_this\_rds\_instance\_tags) | The tags of new rds instance. |
| <a name="output_this_rds_instance_type"></a> [this\_rds\_instance\_type](#output\_this\_rds\_instance\_type) | The instance type of rds instance. |
| <a name="output_this_security_group_description"></a> [this\_security\_group\_description](#output\_this\_security\_group\_description) | The description of the security group. |
| <a name="output_this_security_group_id"></a> [this\_security\_group\_id](#output\_this\_security\_group\_id) | The ID of the security group. |
| <a name="output_this_security_group_name"></a> [this\_security\_group\_name](#output\_this\_security\_group\_name) | The name of the security group. |
| <a name="output_this_security_group_vpc_id"></a> [this\_security\_group\_vpc\_id](#output\_this\_security\_group\_vpc\_id) | The VPC ID. |
| <a name="output_this_slb_id"></a> [this\_slb\_id](#output\_this\_slb\_id) | The id of new slb. |
| <a name="output_this_slb_ip_address"></a> [this\_slb\_ip\_address](#output\_this\_slb\_ip\_address) | The ip address of new slb. |
| <a name="output_this_slb_name"></a> [this\_slb\_name](#output\_this\_slb\_name) | The name of new slb. |
| <a name="output_this_slb_tags"></a> [this\_slb\_tags](#output\_this\_slb\_tags) | The tags of new slb. |
| <a name="output_this_snat_table_id"></a> [this\_snat\_table\_id](#output\_this\_snat\_table\_id) | The snat table id in this nat gateway. |
| <a name="output_this_vpc_cidr_block"></a> [this\_vpc\_cidr\_block](#output\_this\_vpc\_cidr\_block) | The VPC cidr block. |
| <a name="output_this_vpc_id"></a> [this\_vpc\_id](#output\_this\_vpc\_id) | The ID of the VPC. |
| <a name="output_this_vpc_name"></a> [this\_vpc\_name](#output\_this\_vpc\_name) | The VPC name |
| <a name="output_this_vpc_tags"></a> [this\_vpc\_tags](#output\_this\_vpc\_tags) | The tags of the VPC. |
| <a name="output_this_vswitch_cidr_blocks"></a> [this\_vswitch\_cidr\_blocks](#output\_this\_vswitch\_cidr\_blocks) | List cidr blocks of vswitch. |
| <a name="output_this_vswitch_ids"></a> [this\_vswitch\_ids](#output\_this\_vswitch\_ids) | List of IDs of vswitch. |
| <a name="output_this_vswitch_names"></a> [this\_vswitch\_names](#output\_this\_vswitch\_names) | List names of vswitch. |
| <a name="output_this_vswitch_tags"></a> [this\_vswitch\_tags](#output\_this\_vswitch\_tags) | List tags of vswitch. |
<!-- END_TF_DOCS -->

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

