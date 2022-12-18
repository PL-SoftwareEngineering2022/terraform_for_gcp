// Redis instance
resource "google_redis_instance" "webapp_memory_cache" {
  name           = var.redis_instance_name
  tier           = var.redis_tier
  region         = var.region
  memory_size_gb = var.redis_memory_size_gb
  location_id    = var.redis_location_id 
  authorized_network = var.vpc_self_link  #"https://www.googleapis.com/compute/v1/projects/phyll-mamz-playground/global/networks/phyll-mamz-vpc"
  redis_version = var.redis_version
  display_name  = var.redis_display_name
}

// SQL instance
resource "google_sql_database_instance" "webapp_sql_instance" {
  name             = var.sql_db_name
  database_version = var.sql_db_version
  region           = var.region

  settings {
    # Second-generation instance tiers are based on the machine type. See argument reference below.
    tier = var.sql_tier
  }

  deletion_protection = var.sql_deletion_protection
}