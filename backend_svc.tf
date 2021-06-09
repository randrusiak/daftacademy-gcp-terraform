resource "google_service_account" "backend_sa" {
  account_id   = "backend-sa"
  display_name = "backend-sa"
}

resource "google_project_iam_member" "backend_sa" {
  role   = "roles/iam.serviceAccountUser"
  member = "serviceAccount:${google_service_account.backend_sa.email}"
}

resource "google_cloud_run_service" "backend" {
  name     = "backend-app"
  location = var.gcp_region

  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.cloud_run.id
        "run.googleapis.com/vpc-access-egress"    = "all"
        "autoscaling.knative.dev/maxScale"        = 2
        "autoscaling.knative.dev/minScale"        = 1
      }
    }
    spec {
      service_account_name = google_service_account.backend_sa.email
      containers {

        image = "eu.gcr.io/daftacademy-tf-intro/demo-backend:latest"

        env {
          name  = "STORAGE_TYPE"
          value = "gcs"
        }
        env {
          name  = "GCS_BUCKET_NAME"
          value = google_storage_bucket.daftmemes.name
        }
        env {
          name  = "DB_NAME"
          value = google_sql_database.daftmemes.name
        }
        env {
          name  = "DB_USER"
          value = google_sql_user.daftmemes.name
        }
        env {
          name  = "DB_PASS"
          value = google_sql_user.daftmemes.password
        }

        env {
          name  = "DB_HOST"
          value = google_sql_database_instance.main.private_ip_address
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
  autogenerate_revision_name = true
}

resource "google_cloud_run_service_iam_member" "backend_public_access" {
  location = var.gcp_region
  service  = google_cloud_run_service.backend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}