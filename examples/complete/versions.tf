terraform {
  required_version = ">= 0.13"
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"

      version = ">= 2.0.0"
    }
  }
}
