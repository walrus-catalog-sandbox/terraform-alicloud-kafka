terraform {
  required_version = ">= 1.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
    alicloud = {
      source  = "aliyun/alicloud"
      version = ">= 1.212.0"
    }
  }
}

provider "alicloud" {}

locals {
  storage = {
    class = 0
  }
}

data "alicloud_zones" "selected" {
  enable_details = true
}

# create vpc.

resource "alicloud_vpc" "example" {
  vpc_name    = "example"
  cidr_block  = "10.0.0.0/16"
  description = "example"
}

resource "alicloud_vswitch" "example" {
  vpc_id     = alicloud_vpc.example.id
  zone_id    = data.alicloud_zones.selected.zones[0].id
  cidr_block = alicloud_vpc.example.cidr_block
}

# create kms key.

data "alicloud_kms_keys" "example" {
  description_regex = "example"
}

resource "alicloud_kms_key" "example" {
  count = length(data.alicloud_kms_keys.example.ids) == 0 ? 1 : 0

  key_usage              = "ENCRYPT/DECRYPT"
  key_spec               = "Aliyun_AES_256"
  pending_window_in_days = "7"
  status                 = "Enabled"
  automatic_rotation     = "Disabled"
  description            = "example"
}

# create kafka service.

module "this" {
  source = "../.."

  infrastructure = {
    vpc_id     = alicloud_vpc.example.id
    kms_key_id = length(data.alicloud_kms_keys.example.ids) == 0 ? alicloud_kms_key.example[0].id : data.alicloud_kms_keys.example.ids[0]
  }

  storage = local.storage

  seeding = [
    {
      topic      = "example1",
      partitions = 1,
      remark     = "example 1"
    },
    {
      topic      = "example2",
      partitions = 2,
      remark     = "example 2"
    }
  ]
}

output "context" {
  value = module.this.context
}

output "refer" {
  value = nonsensitive(module.this.refer)
}

output "connection" {
  value = module.this.connection
}

output "address" {
  value = module.this.address
}

output "port" {
  value = module.this.port
}

output "endpoints" {
  value = module.this.endpoints
}

output "consumer_group_id" {
  value = module.this.consumer_group_id
}
