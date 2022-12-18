module "network" {
  source                  = "../modules/network"
  vpc_name                = var.vpc_name
  auto_create_subnetworks = var.auto_create_subnetworks
  project                 = var.project
  subnet1_name            = var.subnet1_name
  primary_ip_range_gke    = var.primary_ip_range_gke
  region                  = var.region
  range_name              = var.range_name
  secondary_ip_range      = var.secondary_ip_range
  subnet2_name            = var.subnet2_name
  ip_cidr_range_compute   = var.ip_cidr_range_compute
  region_compute          = var.region_compute
  firewall_name           = var.firewall_name
}

module "gke" {
  source                   = "../modules/gke"
  gke_cluster_name         = var.gke_cluster_name
  gke_cluster_location     = var.gke_cluster_location
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count
  gke_node_pool_name       = var.gke_node_pool_name
  node_count               = var.node_count
  gke_preemptibility       = var.gke_preemptibility
  gke_machine_type         = var.gke_machine_type
  sa_email                 = google_service_account.web_app_project_sa.email
}

module "compute_instances" {
  source              = "../modules/compute_instances"
  static_ip_name      = var.static_ip_name
  static_address_type = var.static_address_type
  region_compute      = var.region_compute
  ce_name             = var.ce_name
  ce_machine_type     = var.ce_machine_type
  ce_zone             = var.ce_zone
  ce_boot_disk_image  = var.ce_boot_disk_image
  env                 = var.env
  vpc_name            = var.vpc_name
  subnet2_name        = var.subnet2_name
  vpc_self_link       = module.network.network_self_link
  subnet2_self_link   = module.network.subnet2_self_link
}

module "databases" {
  source               = "../modules/data"
  redis_instance_name  = var.redis_instance_name
  redis_tier           = var.redis_tier
  region               = var.region
  redis_memory_size_gb = var.redis_memory_size_gb
  redis_location_id    = var.redis_location_id
  redis_version        = var.redis_version
  redis_display_name   = var.redis_display_name
  vpc_name             = var.vpc_name
  vpc_self_link        = module.network.network_self_link
  
  // SQL instance
  sql_db_name             = var.sql_db_name
  sql_db_version          = var.sql_db_version
  sql_tier                = var.sql_tier
  sql_deletion_protection = var.sql_deletion_protection


  // gcs buckets
  gcs_bucket_name             = var.gcs_bucket_name
  gcs_location                = var.gcs_location
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access
  versioning_enabled          = var.versioning_enabled
}