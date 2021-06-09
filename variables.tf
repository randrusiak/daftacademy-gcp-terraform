variable "gcp_project_name" {
  type = string
}

variable "gcp_region" {
  type    = string
  default = "europe-central2"
}

variable "db_availability_type" {
  type    = string
  default = "ZONAL"
  validation {
    condition     = contains(["ZONAL", "REGIONAL"], var.db_availability_type)
    error_message = "Invalid db_availability_type. Value must be one of [ZONAL, REGIONAL]."
  }
}