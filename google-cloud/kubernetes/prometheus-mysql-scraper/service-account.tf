resource "google_service_account" "cloudsql" {
  account_id   = "${var.service_name}-account"
  display_name = "${var.service_name} Service Account"
  project      = "${var.project}"
}

resource "google_service_account_key" "cloudsql" {
  service_account_id = "${google_service_account.cloudsql.name}"
}
