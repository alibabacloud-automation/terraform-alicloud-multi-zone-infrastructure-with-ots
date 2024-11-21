
# Complete

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_infrastructure"></a> [infrastructure](#module\_infrastructure) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

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