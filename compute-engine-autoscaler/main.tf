provider "google" {
  project     = var.project
  region      = var.region
}

resource "google_compute_autoscaler" "default" {
  name   = "my-autoscaler-test"
  zone   = var.zone
  target = google_compute_instance_group_manager.default.id

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

resource "google_compute_instance_template" "default" {
  name           = "template-instance"
  machine_type   = var.machine_type
  can_ip_forward = false

  tags = ["ssh"]

  disk {
    source_image = data.google_compute_image.ubuntu-18.id
  }

  network_interface {
    network = "default"
  }

  metadata = {
    foo = "bar"
  }

  service_account {
    scopes = [var.scopes]
  }
}

resource "google_compute_target_pool" "default" {

  name = "my-target-pool"
}

resource "google_compute_instance_group_manager" "default" {

  name = "my-instance-group-manager"
  zone = var.zone

  version {
    instance_template = google_compute_instance_template.default.id
    name              = "primary"
  }

  target_pools       = [google_compute_target_pool.default.id]
  base_instance_name = "autoscaler-sample"
}

data "google_compute_image" "ubuntu-18" {
  family  = "ubuntu-1804-lts"
  project = "ubuntu-os-cloud"

}
