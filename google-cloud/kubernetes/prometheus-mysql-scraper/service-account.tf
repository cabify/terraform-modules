resource "google_service_account" "cloudsql" {
  account_id   = "${var.service_name}-prometheus-account"
  display_name = "${var.service_name} Service Account for prometheus"
  project      = "${var.project}"
}

resource "google_service_account_key" "cloudsql" {
  service_account_id = "${google_service_account.cloudsql.name}"
}

resource "google_project_iam_member" "cloudsql" {
  project = "${var.project}"
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloudsql.email}"
}
