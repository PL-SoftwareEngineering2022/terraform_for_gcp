resource "google_storage_bucket" "backend_bucket" {
  name          = "phyllmamz-playground-backend-bucket-tfstate"
  force_destroy = true
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

terraform {
 backend "gcs" {
   bucket  = "phyllmamz-playground-backend-bucket-tfstate"
   prefix  = "terraform/state"
 }
}

data "terraform_remote_state" "remote_backend" {
  backend = "gcs"
  config = {
    bucket = "phyllmamz-playground-backend-bucket-tfstate"
    prefix = "terraform/state"
  }
}