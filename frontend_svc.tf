resource "google_cloud_run_service" "frontend" {
  name     = "frontend-app"
  location = var.gcp_region

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = 2
        "autoscaling.knative.dev/minScale" = 1
      }
    }
    spec {
      containers {

        image = "eu.gcr.io/daftacademy-tf-intro/demo-frontend:latest"

        env {
          name  = "REACT_APP_API_URL"
          value = google_cloud_run_service.backend.status[0].url
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

resource "google_cloud_run_service_iam_member" "frontend_public_access" {
  location = var.gcp_region
  service  = google_cloud_run_service.frontend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}