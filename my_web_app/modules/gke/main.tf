//gke
# Google recommends custom service accounts that have cloud-platform scope and 
# permissions granted via IAM Roles. 
# resource "google_service_account" "gke_sa" {
#   account_id   = "webapp-gke-sa"
#   display_name = "service account for GKE"
# }

resource "google_container_cluster" "webapp-gke-cluster" {
  name     = var.gke_cluster_name
  location = var.gke_cluster_location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count
}

resource "google_container_node_pool" "webapp_preemptible_gke_nodes" {
  name       = var.gke_node_pool_name
  location   = var.gke_cluster_location
  cluster    = google_container_cluster.webapp-gke-cluster.name
  node_count = var.node_count

  node_config {
    preemptible  = var.gke_preemptibility
    machine_type = var.gke_machine_type

    service_account = var.sa_email #  # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles. 
    # In this case, this should be: gke_sa google_service_account.gke_sa.email, but we are using the one already formed in the root module in the iam.tf file
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}