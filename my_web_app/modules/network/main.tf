// network
resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = var.vpc_name
  auto_create_subnetworks = var.auto_create_subnetworks
}

resource "google_compute_subnetwork" "webapp_subnet1" {
  project       = var.project
  name          = var.subnet1_name
  ip_cidr_range = var.primary_ip_range_gke
  region        = var.region
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = var.range_name
    ip_cidr_range = var.secondary_ip_range
  }
}

resource "google_compute_subnetwork" "webapp_subnet2" {
  project       = var.project
  name          = var.subnet2_name
  ip_cidr_range = var.ip_cidr_range_compute
  region        = var.region_compute
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "webapp_firewall_rules" {
  name    = var.firewall_name
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "3306", "6379", "443"]
  }

  source_tags = ["http", "https", "ssh"]
}
