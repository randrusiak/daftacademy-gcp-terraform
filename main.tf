terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.71.0"
    }
  }
  required_version = "0.15.5"
}

provider "google" {
  project = var.gcp_project_name
  region  = var.gcp_region
}
