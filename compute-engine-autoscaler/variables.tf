variable "region" {

  default = "us-east1"

}

variable "zone" {

  default = "us-east1-c"

}

variable "machine_type" {

  default = "e2-small"

}

variable "project" {

  default = "civic-matrix-356905"

}

variable "type-boot-disk" {

  default = "pd-balanced"

}

variable "size-boot-disk" {

  default = "10"

}

variable "desired-status" {

  default = "RUNNING"

}

variable "image" {

  default = "ubuntu-1804-bionic-v20220712"

}

variable "environment" {

  default = "dev"

}

variable "network-tier" {

  default = "PREMIUM"

}

variable "network" {

  default = "default"

}

variable "stack-type" {

  default = "IPV4_ONLY"

}

variable "email" {

  type = string
  description = "terraform-user-count"
  default = "terraform-user@civic-matrix-356905.iam.gserviceaccount.com"

}

variable "scopes" {

  type = string
  description = "Scope google cloud platform"
  default = "https://www.googleapis.com/auth/cloud-platform"

}

variable "tags"  {

  type = string
  default = "test"

}