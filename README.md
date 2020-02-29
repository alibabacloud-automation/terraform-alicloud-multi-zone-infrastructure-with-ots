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

## Terraform versions

The Module requires Terraform 0.12 and Terraform Provider AliCloud 1.56.0+.

## Usage

Create both VPC and Security group.

```hcl
module "infrastructure" {
  source  = "terraform-alicloud-modules/multi-zone-infrastructure-with-ots/alicloud"
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  
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

  # create rds instance
  create_rds_instance = true 
  rds_engine          = "MySQL"
  rds_engine_version  = "5.7"
  
  # create table store
  create_ots_instance = true
  ots_instance_name   = "main-ots"
  create_ots_table    = true
  ots_table_name      = "tf_ots_table"
  primary_key = [
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
* This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by He Guimin(@xiaozhu36, heguimin36@163.com).

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

