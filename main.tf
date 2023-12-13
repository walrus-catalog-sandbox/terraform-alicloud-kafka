locals {
  project_name     = coalesce(try(var.context["project"]["name"], null), "default")
  project_id       = coalesce(try(var.context["project"]["id"], null), "default_id")
  environment_name = coalesce(try(var.context["environment"]["name"], null), "test")
  environment_id   = coalesce(try(var.context["environment"]["id"], null), "test_id")
  resource_name    = coalesce(try(var.context["resource"]["name"], null), "example")
  resource_id      = coalesce(try(var.context["resource"]["id"], null), "example_id")

  namespace = join("-", [local.project_name, local.environment_name])

  tags = {
    "Name" = join("-", [local.namespace, local.resource_name])

    "walrus.seal.io/catalog-name"     = "terraform-alicloud-rds-mysql"
    "walrus.seal.io/project-id"       = local.project_id
    "walrus.seal.io/environment-id"   = local.environment_id
    "walrus.seal.io/resource-id"      = local.resource_id
    "walrus.seal.io/project-name"     = local.project_name
    "walrus.seal.io/environment-name" = local.environment_name
    "walrus.seal.io/resource-name"    = local.resource_name
  }
}

#
# Ensure
#

data "alicloud_vpcs" "selected" {
  ids = [var.infrastructure.vpc_id]

  status = "Available"

  lifecycle {
    postcondition {
      condition     = length(self.ids) == 1
      error_message = "VPC is not avaiable"
    }
  }
}

data "alicloud_vswitches" "selected" {
  vpc_id = data.alicloud_vpcs.selected.ids[0]

  lifecycle {
    postcondition {
      condition     = length(self.ids) > 0
      error_message = "VPC needs at least one VSwitch"
    }
  }
}

data "alicloud_kms_keys" "selected" {
  count = var.infrastructure.kms_key_id != null ? 1 : 0

  ids = [var.infrastructure.kms_key_id]

  status = "Enabled"
}

# create the name with a random suffix.

resource "random_string" "name_suffix" {
  length  = 10
  special = false
  upper   = false
}

locals {
  name     = join("-", [local.resource_name, random_string.name_suffix.result])
  fullname = join("-", [local.namespace, local.name])
  description = "Created by Walrus catalog, and provisioned by Terraform."
}

#
# Deployment
#

resource "alicloud_security_group" "default" {
  vpc_id = data.alicloud_vpcs.selected.ids[0]
}

resource "alicloud_alikafka_instance" "default" {
  name           = local.fullname
  tags           = local.tags

  partition_num  = 0
  disk_type      = try(var.storage.class, 0)
  disk_size      = try(var.storage.size, 500)
  deploy_type    = 5
  io_max         = 20
  vswitch_id     = data.alicloud_vswitches.selected.vswitches[0].id
  security_group = alicloud_security_group.default.id
  kms_key_id     = try(data.alicloud_kms_keys.selected[0].ids[0], null)
}

resource "alicloud_alikafka_consumer_group" "default" {
  description = local.description

  instance_id = alicloud_alikafka_instance.default.id
  consumer_id = local.fullname
}

resource "alicloud_alikafka_topic" "dynamic" {
  count = var.seeding == null ? 0 : length(var.seeding)

  remark        = local.description

  instance_id   = alicloud_alikafka_instance.default.id
  topic         = var.seeding[count.index].topic
  partition_num = var.seeding[count.index].partitions
}
