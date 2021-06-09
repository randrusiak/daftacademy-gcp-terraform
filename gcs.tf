resource "google_storage_bucket" "daftmemes" {
  name          = "daftmemes-image-storage-demo"
  location      = var.gcp_region
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "daftmemes_public_access" {
  bucket = google_storage_bucket.daftmemes.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "daftmemes_backend_sa_admin" {
  bucket = google_storage_bucket.daftmemes.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.backend_sa.email}"
}
