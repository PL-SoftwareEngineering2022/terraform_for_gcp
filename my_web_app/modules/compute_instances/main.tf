
//compute instance
resource "google_compute_address" "webapp_server_static_ip" {
  name         = var.static_ip_name
  address_type = var.static_address_type
  region       = var.region_compute
}

resource "google_compute_instance" "webapp-server" {
  name         = var.ce_name
  machine_type = var.ce_machine_type
  zone         = var.ce_zone

  tags = ["http", "https", "ssh"]

  boot_disk {
    initialize_params {
      image = var.ce_boot_disk_image
      labels = {
        env = var.env
      }
    }
  }

  network_interface {
    network    = "https://www.googleapis.com/compute/v1/projects/phyll-mamz-playground/global/networks/phyll-mamz-vpc" # module.<module_name>.<output_value_name>
    subnetwork = "https://www.googleapis.com/compute/v1/projects/phyll-mamz-playground/regions/europe-west1/subnetworks/compute-subnetwork"
    access_config {
      nat_ip = google_compute_address.webapp_server_static_ip.address
    }
  }

  metadata_startup_script = file("./startup_script.sh")
}