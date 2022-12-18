output "network_name" {
  value       = google_compute_network.vpc_network.name
  description = "Name of the VPC being created"
}

output "network_self_link" {
  value       = google_compute_network.vpc_network.self_link
  description = "URL of the VPC being created"
}

output "subnet2_self_link" {
    value = google_compute_subnetwork.webapp_subnet2.self_link
}