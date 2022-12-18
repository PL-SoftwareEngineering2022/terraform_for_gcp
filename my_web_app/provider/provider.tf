terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.46.0"
    }
  }

  # backend "gcs" {
  #   bucket = "phyllmamz-playground-backend-bucket-tfstate"
  #   prefix = "terraform/state"
  # }
}

provider "google" {
  project = var.project
}

