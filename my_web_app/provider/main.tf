// network
resource "google_compute_network" "vpc_network" {
  project                 = "phyll-mamz-playground"
  name                    = "phyll-mamz-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "webapp_subnet1" {
  project = "phyll-mamz-playground"
  name          = "gke-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "gke-secondary-subnet"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_subnetwork" "webapp_subnet2" {
  project = "phyll-mamz-playground"  
  name          = "compute-subnetwork"
  ip_cidr_range = "10.4.0.0/16"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id
}

//gke
resource "google_container_cluster" "webapp-gke-cluster" {
  name     = "webapp-gke-cluster"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "webapp_preemptible_gke_nodes" {
  name       = "webapp-gke-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.webapp-gke-cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.web_app_project.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}