variable "project" {
  default = "phyll-mamz-playground"
}

variable "vpc_name" {
  default = "phyll-mamz-vpc"
}

variable "auto_create_subnetworks" {
  default = false
}

variable "subnet1_name" {
  default = "gke-subnetwork"
}

variable "primary_ip_range_gke" {
  default = "10.2.0.0/16"
}

variable "region" {
  default = "us-central1"
}

variable "range_name" {
  default = "gke-secondary-subnet"
}

variable "secondary_ip_range" {
  default = "192.168.10.0/24"
}

variable "subnet2_name" {
  default = "compute-subnetwork"
}

variable "ip_cidr_range_compute" {
  default = "10.4.0.0/16"
}

variable "region_compute" {
  default = "europe-west1"
}

variable "firewall_name" {
  default = "webapp-firewall"
}

variable "gke_cluster_name" {
  default = "webapp-gke-cluster"
}
variable "gke_cluster_location" {
  default = "us-central1"
}

variable "remove_default_node_pool" {
  default = true
}

variable "initial_node_count" {
  default = 1
}

variable "gke_node_pool_name" {
  default = "webapp-gke-node-pool"
}

variable "node_count" {
  default = 1
}

variable "gke_preemptibility" {
  default = true
}

variable "gke_machine_type" {
  default = "e2-medium"
}

variable "redis_instance_name" {
  default = "webapp-memory-cache"
}

variable "redis_tier" {
  default = "BASIC"
}

variable "redis_memory_size_gb" {
  default = 1
}

variable "redis_version" {
  default = "REDIS_4_0"
}

variable "redis_display_name" {
  default = "Webapp Redis Instance"
}

variable "gcs_bucket_name" {
  default = "phyll-mamz-webapp-gcs-bucket"
}

variable "gcs_location" {
  default = "US"
}

variable "force_destroy" {
  default = true
}

variable "uniform_bucket_level_access" {
  default = true
}

variable "versioning_enabled" {
  default = true
}

variable "sql_db_name" {
  default = "webapp-sql-instance"
}

variable "sql_db_version" {
  default = "MYSQL_8_0"
}

variable "sql_tier" {
  default = "db-f1-micro"
}

variable "sql_deletion_protection" {
  default = false
}

variable "static_ip_name" {
  default = "webapp-server-static-ip"
}

variable "static_address_type" {
  default = "EXTERNAL"
}

variable "ce_name" {
  default = "webapp-server"
}

variable "ce_machine_type" {
  default = "e2-medium"
}

variable "ce_zone" {
  default = "europe-west1-b"
}

variable "ce_boot_disk_image" {
  default = "debian-cloud/debian-11"
}

variable "env" {
  default = "prod"
}

variable "redis_location_id" {
  default = "us-central1-a"
}

