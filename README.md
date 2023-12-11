# Alibaba ApsaraMQ for Apache Kafka Service

Terraform module which deploys [Kafka](https://www.alibabacloud.com/help/en/message-queue-for-apache-kafka) service on Alibaba Cloud.

## Usage

```hcl
module "kafka" {
  source = "..."

  infrastructure = {
    vpc_id        = "..."
  }
}
```

## Examples

- [Complete](./examples/complete)

## Contributing

Please read our [contributing guide](./docs/CONTRIBUTING.md) if you're interested in contributing to Walrus template.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.212.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.212.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_alikafka_consumer_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_consumer_group) | resource |
| [alicloud_alikafka_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_instance) | resource |
| [alicloud_alikafka_topic.dynamic](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_topic) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [random_string.name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [alicloud_kms_keys.selected](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/kms_keys) | data source |
| [alicloud_vpcs.selected](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpcs) | data source |
| [alicloud_vswitches.selected](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vswitches) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.<br><br>Examples:<pre>context:<br>  project:<br>    name: string<br>    id: string<br>  environment:<br>    name: string<br>    id: string<br>  resource:<br>    name: string<br>    id: string</pre> | `map(any)` | `{}` | no |
| <a name="input_infrastructure"></a> [infrastructure](#input\_infrastructure) | Specify the infrastructure information for deploying.<br><br>Examples:<pre>infrastructure:<br>  vpc_id: string                  # the ID of the VPC where the Kafka service applies<br>  kms_key_id: string,optional     # the ID of the KMS key which to encrypt the Kafka data</pre> | <pre>object({<br>    vpc_id     = string<br>    kms_key_id = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_seeding"></a> [seeding](#input\_seeding) | Specify the configuration to kafka provisioning.<br><br>Examples:<pre>seeding: <br>  - topic: string, optional<br>    partition: number, optional<br>    remark: string, optional</pre> | <pre>list(object({<br>    topic      = optional(string)<br>    partitions = optional(number, 1)<br>    remark     = optional(string, "Created by Walrus catalog, and provisioned by Terraform.")<br>  }))</pre> | `null` | no |
| <a name="input_storage"></a> [storage](#input\_storage) | Specify the disk type of the instance. 0: efficient cloud disk , 1: SSD.<br><br>Examples:<pre>storage:<br>  class: number, optional        # https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_instance#disk_type<br>  size: number, optional         # in megabyte</pre> | <pre>object({<br>    class = optional(number, 0)<br>    size  = optional(number, 500)<br>  })</pre> | <pre>{<br>  "class": 0,<br>  "size": 500<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | The address, a string only has host, might be a comma separated string or a single string. |
| <a name="output_connection"></a> [connection](#output\_connection) | The connection, a string combined host and port, might be a comma separated string or a single string. |
| <a name="output_consumer_group_id"></a> [consumer\_group\_id](#output\_consumer\_group\_id) | The consumer group id. |
| <a name="output_context"></a> [context](#output\_context) | The input context, a map, which is used for orchestration. |
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | The endpoints, a list of string combined host and port. |
| <a name="output_port"></a> [port](#output\_port) | The port of the service. |
| <a name="output_refer"></a> [refer](#output\_refer) | The refer, a map, including hosts, ports and account, which is used for dependencies or collaborations. |
<!-- END_TF_DOCS -->

## License

Copyright (c) 2023 [Seal, Inc.](https://seal.io)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [LICENSE](./LICENSE) file for details.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
