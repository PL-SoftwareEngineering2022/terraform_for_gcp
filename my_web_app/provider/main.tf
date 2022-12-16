// network
resource "google_compute_network" "vpc_network" {
  project                 = "phyll-mamz-playground"
  name                    = "phyll-mamz-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "webapp_subnet1" {
  project       = "phyll-mamz-playground"
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
  project       = "phyll-mamz-playground"
  name          = "compute-subnetwork"
  ip_cidr_range = "10.4.0.0/16"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "webapp_firewall_rules" {
  name    = "webapp-firewall"
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
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
// Storage
// Redis instance
resource "google_redis_instance" "webapp_memory_cache" {
  name           = "webapp-memory-cache"
  tier           = "BASIC"
  region         = "us-central1"
  memory_size_gb = 1

  location_id = "us-central1-a"
  #   alternative_location_id = "us-central1-f" # only for STANDARD_HA... for failover

  authorized_network = google_compute_network.vpc_network.self_link

  redis_version = "REDIS_4_0"
  display_name  = "Webapp Redis Instance"
}

// GCS Bucket
resource "google_storage_bucket" "phyll_mamz_webapp_gcs_bucket" {
  name                        = "phyll-mamz-webapp-gcs-bucket"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

// SQL instance
resource "google_sql_database_instance" "webapp_sql_instance" {
  name             = "webapp-sql-instance"
  database_version = "MYSQL_8_0"
  region           = "us-central1"

  settings {
    # Second-generation instance tiers are based on the machine type. See argument reference below.
    tier = "db-f1-micro"
  }

  deletion_protection = false
}

//compute instance
resource "google_compute_address" "webapp_server_static_ip" {
  name         = "webapp-server-static-ip"
  address_type = "EXTERNAL"
  region       = "europe-west1"
}
resource "google_compute_instance" "webapp-server" {
  name         = "webapp-server"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"

  tags = ["http", "https", "ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        env = "prod"
      }
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.webapp_subnet2.self_link

    access_config {
      nat_ip = google_compute_address.webapp_server_static_ip.address
    }
  }

  metadata_startup_script = file("./startup_script.sh")

  #   service_account {
  #     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
  #     email  = google_service_account.default.email
  #     scopes = ["cloud-platform"]
  #   }
}