variable "region" {
  type        = string
  description = "AWS region"
}

variable "instance_type" {
  type        = string
  description = "The type of the instance"
}

variable "aws_service_type" {
  type        = string
  description = "The type of AWS service to deploy (`elasticsearch` or `opensearch`)."
  # For backwards comptibility we default to elasticsearch
  default = "elasticsearch"

  validation {
    condition     = contains(["elasticsearch", "opensearch"], var.aws_service_type)
    error_message = "Value can only be one of `elasticsearch` or `opensearch`."
  }
}

variable "elasticsearch_version" {
  type        = string
  description = "Version of Elasticsearch or Opensearch to deploy (_e.g._ `7.1`, `6.8`, `6.7`, `6.5`, `6.4`, `6.3`, `6.2`, `6.0`, `5.6`, `5.5`, `5.3`, `5.1`, `2.3`, `1.5`"
}

variable "encrypt_at_rest_enabled" {
  type        = bool
  description = "Whether to enable encryption at rest"
}

variable "dedicated_master_enabled" {
  type        = bool
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
}

variable "dedicated_master_count" {
  type        = number
  description = "Number of dedicated master nodes in the cluster"
  default     = 0
}

variable "dedicated_master_type" {
  type        = string
  default     = "t2.small.elasticsearch"
  description = "Instance type of the dedicated master nodes in the cluster"
}

variable "elasticsearch_subdomain_name" {
  type        = string
  description = "The name of the subdomain for Elasticsearch in the DNS zone (_e.g._ `elasticsearch`, `ui`, `ui-es`, `search-ui`)"
}

variable "kibana_subdomain_name" {
  type        = string
  description = "The name of the subdomain for Kibana in the DNS zone (_e.g._ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`)"
}

variable "create_iam_service_linked_role" {
  type        = bool
  description = <<-EOT
  Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role.
  Set this to `false` if you already have an ElasticSearch cluster created in the AWS account and `AWSServiceRoleForAmazonElasticsearchService` already exists.
  See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more information.
  EOT
}

variable "ebs_volume_size" {
  type        = number
  description = "EBS volumes for data storage in GB"
}

variable "domain_hostname_enabled" {
  type        = bool
  description = "Explicit flag to enable creating a DNS hostname for ES. If `true`, then `var.dns_zone_id` is required."
}

variable "kibana_hostname_enabled" {
  type        = bool
  description = "Explicit flag to enable creating a DNS hostname for Kibana. If `true`, then `var.dns_zone_id` is required."
}

# https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-ac.html
variable "elasticsearch_iam_actions" {
  type        = list(string)
  default     = ["es:ESHttpGet", "es:ESHttpPut", "es:ESHttpPost", "es:ESHttpHead", "es:Describe*", "es:List*"]
  description = "List of actions to allow for the IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost`"
}

variable "elasticsearch_iam_role_arns" {
  type        = list(string)
  default     = []
  description = "List of additional IAM role ARNs to permit access to the Elasticsearch domain"
}

variable "elasticsearch_password" {
  type        = string
  description = "Password for the elasticsearch user"
  default     = ""

  # "sensitive" required Terraform 0.14 or later
  #  sensitive   = true

  validation {
    condition = (
      length(var.elasticsearch_password) == 0 ||
      (length(var.elasticsearch_password) >= 8 &&
      length(var.elasticsearch_password) <= 128)
    )
    error_message = "Password must be between 8 and 128 characters. If null is provided then a random password will be used."
  }
}

variable "elasticsearch_saml_options" {
  type = object({
    enabled          = optional(bool, false)
    entity_id        = optional(string)
    metadata_content = optional(string)
  })
  description = <<-EOT
 Manages SAML authentication options for an AWS OpenSearch Domain

 enabled: Whether to enable SAML authentication for the OpenSearch Domain
 entity_id: The entity ID of the IdP
 metadata_content: The metadata of the IdP
 EOT
  default     = {}
}

variable "elasticsearch_log_cleanup_enabled" {
  type        = bool
  description = "Whether to enable Elasticsearch log cleanup Lambda"
  default     = true
}

variable "dns_delegated_environment_name" {
  type        = string
  description = "The name of the environment where the `dns-delegated` component is deployed"
  default     = "gbl"
}
