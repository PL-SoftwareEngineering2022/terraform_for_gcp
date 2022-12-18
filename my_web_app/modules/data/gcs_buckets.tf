// GCS Bucket
resource "google_storage_bucket" "phyll_mamz_webapp_gcs_bucket" {
  name                        = var.gcs_bucket_name
  location                    = var.gcs_location
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access
  versioning {
    enabled = var.versioning_enabled
  }
}