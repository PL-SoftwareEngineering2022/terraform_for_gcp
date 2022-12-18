output "sa_email" {
  value = google_service_account.web_app_project_sa.email
}

output "network_self_link" {
  value       = module.network.network_self_link
  description = "URL of the VPC being created"
}

output "subnet2_self_link" {
  value       = module.network.subnet2_self_link
  description = "URL of the Subnet being created"
}


