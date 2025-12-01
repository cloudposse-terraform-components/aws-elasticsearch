---
tags:
  - component/elasticsearch
  - layer/data
  - provider/aws
---

# Component: `elasticsearch`

This component is responsible for provisioning an Elasticsearch cluster with built-in integrations with Kibana and Logstash.
## Usage

**Stack Level**: Regional

Here's an example snippet for how to use this component.

```yaml
components:
  terraform:
    elasticsearch:
      vars:
        enabled: true
        name: foobar
        instance_type: "t3.medium.elasticsearch"
        elasticsearch_version: "7.9"
        encrypt_at_rest_enabled: true
        dedicated_master_enabled: false
        elasticsearch_subdomain_name: "es"
        kibana_subdomain_name: "kibana"
        ebs_volume_size: 40
        create_iam_service_linked_role: true
        kibana_hostname_enabled: true
        domain_hostname_enabled: true
```


<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9.0, < 6.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9.0, < 6.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns_delegated"></a> [dns\_delegated](#module\_dns\_delegated) | cloudposse/stack-config/yaml//modules/remote-state | 1.8.0 |
| <a name="module_elasticsearch"></a> [elasticsearch](#module\_elasticsearch) | cloudposse/elasticsearch/aws | 2.1.0 |
| <a name="module_elasticsearch_log_cleanup"></a> [elasticsearch\_log\_cleanup](#module\_elasticsearch\_log\_cleanup) | cloudposse/lambda-elasticsearch-cleanup/aws | 0.16.1 |
| <a name="module_iam_roles"></a> [iam\_roles](#module\_iam\_roles) | ../account-map/modules/iam-roles | n/a |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | cloudposse/stack-config/yaml//modules/remote-state | 1.8.0 |

## Resources

| Name | Type |
|------|------|
| [aws_elasticsearch_domain_saml_options.elasticsearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain_saml_options) | resource |
| [aws_opensearch_domain_saml_options.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain_saml_options) | resource |
| [aws_ssm_parameter.admin_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.elasticsearch_domain_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.elasticsearch_kibana_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.elasticsearch_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br/>This is for some rare cases where resources want additional configuration of tags<br/>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_advanced_security_options_anonymous_auth_enabled"></a> [advanced\_security\_options\_anonymous\_auth\_enabled](#input\_advanced\_security\_options\_anonymous\_auth\_enabled) | Whether Anonymous auth is enabled. Enables fine-grained access control on an existing domain | `bool` | `false` | no |
| <a name="input_advanced_security_options_enabled"></a> [advanced\_security\_options\_enabled](#input\_advanced\_security\_options\_enabled) | AWS Elasticsearch Kibana enhanced security plugin enabling (forces new resource) | `bool` | `true` | no |
| <a name="input_advanced_security_options_internal_user_database_enabled"></a> [advanced\_security\_options\_internal\_user\_database\_enabled](#input\_advanced\_security\_options\_internal\_user\_database\_enabled) | Whether to enable or not internal Kibana user database for ELK OpenDistro security plugin | `bool` | `true` | no |
| <a name="input_advanced_security_options_master_user_name"></a> [advanced\_security\_options\_master\_user\_name](#input\_advanced\_security\_options\_master\_user\_name) | Master user username (applicable if advanced\_security\_options\_internal\_user\_database\_enabled set to true) | `string` | `"admin"` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br/>in the order they appear in the list. New attributes are appended to the<br/>end of the list. The elements of the list are joined by the `delimiter`<br/>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_aws_service_type"></a> [aws\_service\_type](#input\_aws\_service\_type) | The type of AWS service to deploy (`elasticsearch` or `opensearch`). | `string` | `"elasticsearch"` | no |
| <a name="input_cold_storage_enabled"></a> [cold\_storage\_enabled](#input\_cold\_storage\_enabled) | Enables cold storage support. | `bool` | `false` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br/>See description of individual variables for details.<br/>Leave string and numeric variables as `null` to use default value.<br/>Individual variable settings (non-null) override settings in context object,<br/>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br/>  "additional_tag_map": {},<br/>  "attributes": [],<br/>  "delimiter": null,<br/>  "descriptor_formats": {},<br/>  "enabled": true,<br/>  "environment": null,<br/>  "id_length_limit": null,<br/>  "label_key_case": null,<br/>  "label_order": [],<br/>  "label_value_case": null,<br/>  "labels_as_tags": [<br/>    "unset"<br/>  ],<br/>  "name": null,<br/>  "namespace": null,<br/>  "regex_replace_chars": null,<br/>  "stage": null,<br/>  "tags": {},<br/>  "tenant": null<br/>}</pre> | no |
| <a name="input_create_iam_service_linked_role"></a> [create\_iam\_service\_linked\_role](#input\_create\_iam\_service\_linked\_role) | Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role.<br/>Set this to `false` if you already have an ElasticSearch cluster created in the AWS account and `AWSServiceRoleForAmazonElasticsearchService` already exists.<br/>See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more information. | `bool` | n/a | yes |
| <a name="input_dedicated_master_count"></a> [dedicated\_master\_count](#input\_dedicated\_master\_count) | Number of dedicated master nodes in the cluster | `number` | `0` | no |
| <a name="input_dedicated_master_enabled"></a> [dedicated\_master\_enabled](#input\_dedicated\_master\_enabled) | Indicates whether dedicated master nodes are enabled for the cluster | `bool` | n/a | yes |
| <a name="input_dedicated_master_type"></a> [dedicated\_master\_type](#input\_dedicated\_master\_type) | Instance type of the dedicated master nodes in the cluster | `string` | `"t2.small.elasticsearch"` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br/>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br/>Map of maps. Keys are names of descriptors. Values are maps of the form<br/>`{<br/>  format = string<br/>  labels = list(string)<br/>}`<br/>(Type is `any` so the map values can later be enhanced to provide additional options.)<br/>`format` is a Terraform format string to be passed to the `format()` function.<br/>`labels` is a list of labels, in order, to pass to `format()` function.<br/>Label values will be normalized before being passed to `format()` so they will be<br/>identical to how they appear in `id`.<br/>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_dns_delegated_environment_name"></a> [dns\_delegated\_environment\_name](#input\_dns\_delegated\_environment\_name) | The name of the environment where the `dns-delegated` component is deployed | `string` | `"gbl"` | no |
| <a name="input_domain_hostname_enabled"></a> [domain\_hostname\_enabled](#input\_domain\_hostname\_enabled) | Explicit flag to enable creating a DNS hostname for ES. If `true`, then `var.dns_zone_id` is required. | `bool` | n/a | yes |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | EBS volumes for data storage in GB | `number` | n/a | yes |
| <a name="input_elasticsearch_domain_name"></a> [elasticsearch\_domain\_name](#input\_elasticsearch\_domain\_name) | The name of the Elasticsearch domain. Must be at least 3 and no more than 28 characters long. Valid characters are a-z (lowercase letters), 0-9, and - (hyphen). | `string` | `""` | no |
| <a name="input_elasticsearch_iam_actions"></a> [elasticsearch\_iam\_actions](#input\_elasticsearch\_iam\_actions) | List of actions to allow for the IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost` | `list(string)` | <pre>[<br/>  "es:ESHttpGet",<br/>  "es:ESHttpPut",<br/>  "es:ESHttpPost",<br/>  "es:ESHttpHead",<br/>  "es:Describe*",<br/>  "es:List*"<br/>]</pre> | no |
| <a name="input_elasticsearch_iam_role_arns"></a> [elasticsearch\_iam\_role\_arns](#input\_elasticsearch\_iam\_role\_arns) | List of additional IAM role ARNs to permit access to the Elasticsearch domain | `list(string)` | `[]` | no |
| <a name="input_elasticsearch_log_cleanup_enabled"></a> [elasticsearch\_log\_cleanup\_enabled](#input\_elasticsearch\_log\_cleanup\_enabled) | Whether to enable Elasticsearch log cleanup Lambda | `bool` | `true` | no |
| <a name="input_elasticsearch_password"></a> [elasticsearch\_password](#input\_elasticsearch\_password) | Password for the elasticsearch user | `string` | `""` | no |
| <a name="input_elasticsearch_saml_options"></a> [elasticsearch\_saml\_options](#input\_elasticsearch\_saml\_options) | Manages SAML authentication options for an AWS OpenSearch Domain<br/><br/>enabled: Whether to enable SAML authentication for the OpenSearch Domain<br/>entity\_id: The entity ID of the IdP<br/>metadata\_content: The metadata of the IdP | <pre>object({<br/>    enabled          = optional(bool, false)<br/>    entity_id        = optional(string)<br/>    metadata_content = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_elasticsearch_subdomain_name"></a> [elasticsearch\_subdomain\_name](#input\_elasticsearch\_subdomain\_name) | The name of the subdomain for Elasticsearch in the DNS zone (\_e.g.\_ `elasticsearch`, `ui`, `ui-es`, `search-ui`) | `string` | n/a | yes |
| <a name="input_elasticsearch_version"></a> [elasticsearch\_version](#input\_elasticsearch\_version) | Version of Elasticsearch or Opensearch to deploy (\_e.g.\_ `7.1`, `6.8`, `6.7`, `6.5`, `6.4`, `6.3`, `6.2`, `6.0`, `5.6`, `5.5`, `5.3`, `5.1`, `2.3`, `1.5` | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_encrypt_at_rest_enabled"></a> [encrypt\_at\_rest\_enabled](#input\_encrypt\_at\_rest\_enabled) | Whether to enable encryption at rest | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br/>Set to `0` for unlimited length.<br/>Set to `null` for keep the existing setting, which defaults to `0`.<br/>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance | `string` | n/a | yes |
| <a name="input_kibana_hostname_enabled"></a> [kibana\_hostname\_enabled](#input\_kibana\_hostname\_enabled) | Explicit flag to enable creating a DNS hostname for Kibana. If `true`, then `var.dns_zone_id` is required. | `bool` | n/a | yes |
| <a name="input_kibana_subdomain_name"></a> [kibana\_subdomain\_name](#input\_kibana\_subdomain\_name) | The name of the subdomain for Kibana in the DNS zone (\_e.g.\_ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`) | `string` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br/>Does not affect keys of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper`.<br/>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br/>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br/>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br/>set as tag values, and output by this module individually.<br/>Does not affect values of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br/>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br/>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br/>Default is to include all labels.<br/>Tags with empty values will not be included in the `tags` output.<br/>Set to `[]` to suppress all generated tags.<br/>**Notes:**<br/>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br/>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br/>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br/>  "default"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br/>This is the only ID element not also included as a `tag`.<br/>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_node_to_node_encryption_enabled"></a> [node\_to\_node\_encryption\_enabled](#input\_node\_to\_node\_encryption\_enabled) | Whether to enable node-to-node encryption | `bool` | `true` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br/>Characters matching the regex will be removed from the ID elements.<br/>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br/>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_arn"></a> [domain\_arn](#output\_domain\_arn) | ARN of the Elasticsearch domain |
| <a name="output_domain_endpoint"></a> [domain\_endpoint](#output\_domain\_endpoint) | Domain-specific endpoint used to submit index, search, and data upload requests |
| <a name="output_domain_hostname"></a> [domain\_hostname](#output\_domain\_hostname) | Elasticsearch domain hostname to submit index, search, and data upload requests |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | Unique identifier for the Elasticsearch domain |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Name of the Elasticsearch domain |
| <a name="output_elasticsearch_user_iam_role_arn"></a> [elasticsearch\_user\_iam\_role\_arn](#output\_elasticsearch\_user\_iam\_role\_arn) | The ARN of the IAM role to allow access to Elasticsearch cluster |
| <a name="output_elasticsearch_user_iam_role_name"></a> [elasticsearch\_user\_iam\_role\_name](#output\_elasticsearch\_user\_iam\_role\_name) | The name of the IAM role to allow access to Elasticsearch cluster |
| <a name="output_kibana_endpoint"></a> [kibana\_endpoint](#output\_kibana\_endpoint) | Domain-specific endpoint for Kibana without https scheme |
| <a name="output_kibana_hostname"></a> [kibana\_hostname](#output\_kibana\_hostname) | Kibana hostname |
| <a name="output_master_password_ssm_key"></a> [master\_password\_ssm\_key](#output\_master\_password\_ssm\_key) | SSM key of Elasticsearch master password |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security Group ID to control access to the Elasticsearch domain |
<!-- markdownlint-restore -->



## References


- [cloudposse-terraform-components](https://github.com/orgs/cloudposse-terraform-components/repositories) - Cloud Posse's upstream component




[<img src="https://cloudposse.com/logo-300x69.svg" height="32" align="right"/>](https://cpco.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=cloudposse-terraform-components/aws-elasticsearch&utm_content=)

