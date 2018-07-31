resource "google_service_account" "stackdriver" {
  account_id   = "${var.service}-prometheus-account"
  display_name = "${var.service} Service Account for Prometheus"
  project      = "${var.project}"
}

resource "google_service_account_key" "stackdriver" {
  service_account_id = "${google_service_account.stackdriver.name}"
}

resource "google_project_iam_member" "stackdriver" {
  project = "${var.project}"
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.stackdriver.email}"
}
