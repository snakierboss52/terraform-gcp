provider "google" {
  project     = var.project
  region      = var.region
}

resource "google_compute_instance" "compute-engine-test" {
  name         = "test-instance"
  machine_type = var.machine_type
  //region       = var.region
  zone         = var.zone
  desired_status  = "RUNNING"


  tags = ["test-jenkins"]

  boot_disk {
    initialize_params {
      type  = "pd-balanced"
      size  = "10"
      image = "ubuntu-1804-bionic-v20220712"
    }
  }

  network_interface {
    network = "default"

    access_config {
      network_tier = "PREMIUM"
    }

    stack_type =  "IPV4_ONLY"
  }


   service_account {
    email  = "terraform-user@civic-matrix-356905.iam.gserviceaccount.com"
    scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

}

resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = "pd-balanced"
  size  = "15"
  zone  = var.zone
  image = "ubuntu-1804-bionic-v20220712"
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.id
  instance = google_compute_instance.compute-engine-test.id
}