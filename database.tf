resource "random_string" "db_name_suffix" {
  length    = 4
  min_lower = 4
  special   = false
}

resource "google_sql_database_instance" "main" {
  name                = "daftacademy-db-${random_string.db_name_suffix.result}"
  database_version    = "POSTGRES_12"
  deletion_protection = false

  settings {
    tier              = "db-f1-micro"
    availability_type = var.db_availability_type

    ip_configuration {
      private_network = google_compute_network.private_network.self_link
    }

    backup_configuration {
      enabled    = true
      start_time = "3:00"
    }
  }
  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_database" "daftmemes" {
  name     = "daftmemes"
  instance = google_sql_database_instance.main.name
}

resource "google_sql_user" "daftmemes" {
  name     = "daftmemes"
  instance = google_sql_database_instance.main.name
  password = data.google_secret_manager_secret_version.daftmemes_user_password.secret_data
}

data "google_secret_manager_secret_version" "daftmemes_user_password" {
  secret = "daftmemes_user_password"
}