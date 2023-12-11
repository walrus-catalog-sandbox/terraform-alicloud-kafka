#
# Contextual Fields
#

variable "context" {
  description = <<-EOF
Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.

Examples:
```
context:
  project:
    name: string
    id: string
  environment:
    name: string
    id: string
  resource:
    name: string
    id: string
```
EOF
  type        = map(any)
  default     = {}
}

#
# Infrastructure Fields
#

variable "infrastructure" {
  description = <<-EOF
Specify the infrastructure information for deploying.

Examples:
```
infrastructure:
  vpc_id: string                  # the ID of the VPC where the Kafka service applies
  kms_key_id: string,optional     # the ID of the KMS key which to encrypt the Kafka data
```
EOF
  type = object({
    vpc_id     = string
    kms_key_id = optional(string)
  })
}

#
# Deployment Fields
#

variable "storage" {
  description = <<-EOF
Specify the disk type of the instance. 0: efficient cloud disk , 1: SSD.

Examples:
```
storage:
  class: number, optional        # https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_instance#disk_type
  size: number, optional         # in megabyte
```
EOF
  type = object({
    class = optional(number, 0)
    size  = optional(number, 500)
  })
  default = {
    class = 0
    size  = 500
  }
}

#
# Seeding Fields
#

variable "seeding" {
  description = <<-EOF
  Specify the configuration to kafka provisioning.

  Examples:
  ```
  seeding:
      topics: list(string), optional
      partitions: number, optional
      remark: string, optional
  ```
  EOF
  type = object({
    topics     = optional(list(string))
    partitions = optional(number, 1)
    remark     = optional(string, "Created by Walrus catalog, and provisioned by Terraform.")
  })
  default = null
}