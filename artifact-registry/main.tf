provider "google" {
  project     = var.project
  region      = var.region
}

resource "google_artifact_registry_repository" "gcp-repo-registry" {
  location      = var.region
  repository_id = var.repository_id
  description   = "example docker repository"
  format        = var.format
}