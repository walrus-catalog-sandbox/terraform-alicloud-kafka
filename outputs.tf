locals {
  port = 9092

  hosts = flatten([
    [for addr in split(",", alicloud_alikafka_instance.default.end_point) : split(":", addr)[0]]
  ])

  endpoints = [
    for c in local.hosts : format("%s:%d", c, local.port)
  ]
}

output "context" {
  description = "The input context, a map, which is used for orchestration."
  value       = var.context
}

output "refer" {
  description = "The refer, a map, including hosts, ports and account, which is used for dependencies or collaborations."
  sensitive   = true
  value = {
    schema = "alicloud:alikafka"
    params = {
      selector  = local.tags
      hosts     = local.hosts
      port      = local.port
      endpoints = local.endpoints
    }
  }
}

#
# Reference
#

output "connection" {
  description = "The connection, a string combined host and port, might be a comma separated string or a single string."
  value       = join(",", local.endpoints)
}

output "address" {
  description = "The address, a string only has host, might be a comma separated string or a single string."
  value       = join(",", local.hosts)
}

output "port" {
  description = "The port of the service."
  value       = local.port
}

output "consumer_group_id" {
  description = "The consumer group id."
  value       = alicloud_alikafka_consumer_group.default.consumer_id
}
