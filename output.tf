output "frontend_public_address" {
  value = google_cloud_run_service.frontend.status[0].url
}