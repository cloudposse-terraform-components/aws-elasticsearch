output "security_group_id" {
  value       = local.enabled ? module.elasticsearch.security_group_id : null
  description = "Security Group ID to control access to the Elasticsearch domain"
}

output "domain_arn" {
  value       = local.enabled ? module.elasticsearch.domain_arn : null
  description = "ARN of the Elasticsearch domain"
}

output "domain_id" {
  value       = local.enabled ? module.elasticsearch.domain_id : null
  description = "Unique identifier for the Elasticsearch domain"
}

output "domain_name" {
  value       = local.enabled ? module.elasticsearch.domain_name : null
  description = "Name of the Elasticsearch domain"
}

output "domain_endpoint" {
  value       = local.enabled ? module.elasticsearch.domain_endpoint : null
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
}

output "kibana_endpoint" {
  value       = local.enabled ? module.elasticsearch.kibana_endpoint : null
  description = "Domain-specific endpoint for Kibana without https scheme"
}

output "domain_hostname" {
  value       = local.enabled ? module.elasticsearch.domain_hostname : null
  description = "Elasticsearch domain hostname to submit index, search, and data upload requests"
}

output "kibana_hostname" {
  value       = local.enabled ? module.elasticsearch.kibana_hostname : null
  description = "Kibana hostname"
}

output "elasticsearch_user_iam_role_name" {
  value       = local.enabled ? module.elasticsearch.elasticsearch_user_iam_role_name : null
  description = "The name of the IAM role to allow access to Elasticsearch cluster"
}

output "elasticsearch_user_iam_role_arn" {
  value       = local.enabled ? module.elasticsearch.elasticsearch_user_iam_role_arn : null
  description = "The ARN of the IAM role to allow access to Elasticsearch cluster"
}

output "master_password_ssm_key" {
  value       = local.enabled ? local.elasticsearch_admin_password : null
  description = "SSM key of Elasticsearch master password"
}
