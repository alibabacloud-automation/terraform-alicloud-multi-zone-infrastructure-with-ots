module "infrastructure" {
  source = "../.."

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
