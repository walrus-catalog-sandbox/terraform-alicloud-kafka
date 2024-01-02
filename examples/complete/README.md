# Standalone Example

Deploy Kafka service by root module.

```bash
# setup infra
$ tf apply -auto-approve \
  -target=alicloud_vpc.example \
  -target=alicloud_vswitch.example \
  -target=alicloud_kms_key.example 

# create service
$ tf apply -auto-approve
```

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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_kms_key.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_key) | resource |
| [alicloud_vpc.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_kms_keys.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/kms_keys) | data source |
| [alicloud_zones.selected](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | n/a |
| <a name="output_connection"></a> [connection](#output\_connection) | n/a |
| <a name="output_consumer_group_id"></a> [consumer\_group\_id](#output\_consumer\_group\_id) | n/a |
| <a name="output_context"></a> [context](#output\_context) | n/a |
| <a name="output_port"></a> [port](#output\_port) | n/a |
| <a name="output_refer"></a> [refer](#output\_refer) | n/a |
<!-- END_TF_DOCS -->
