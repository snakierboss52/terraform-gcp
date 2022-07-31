provider "google" {
  project     = var.project
  region      = var.region
}

resource "google_compute_instance" "compute-engine-test" {
  name         = "test-instance"
  machine_type = var.machine_type
  //region       = var.region
  zone         = var.zone
  desired_status  = var.desired-status


  tags = [var.tags]

  boot_disk {
    initialize_params {
      type  = var.type-boot-disk
      size  = var.size-boot-disk
      image = var.image
    }
  }

  network_interface {
    network = var.network

    access_config {
      network_tier = var.network-tier
    }

    stack_type =  "IPV4_ONLY"
  }


   service_account {
    email  = var.email
    scopes = [
        var.scopes
    ]
  }

}

resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = var.type-boot-disk
  size  = var.size-boot-disk
  zone  = var.zone
  image = var.image
  labels = {
    environment = var.environment
  }
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.id
  instance = google_compute_instance.compute-engine-test.id
}