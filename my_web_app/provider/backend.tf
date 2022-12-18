resource "google_storage_bucket" "backend_bucket" {
  name          = "phyllmamz-playground-backend-bucket-tfstate"
  force_destroy = true
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}


# data "terraform_remote_state" "remote_backend" {
#   backend = "gcs"
#   config = {
#     bucket = "phyllmamz-playground-backend-bucket-tfstate"
#     prefix = "terraform/state"
#   }
# }