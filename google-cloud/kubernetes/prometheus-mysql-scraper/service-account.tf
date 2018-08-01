resource "google_service_account" "cloudsql" {
  // 28 char limit
  account_id   = "${substr(var.service_name,0,19)}-prom-sa"
  display_name = "${var.service_name} Service Account for prometheus"
  project      = "${var.project}"
}

resource "google_service_account_key" "cloudsql" {
  service_account_id = "${google_service_account.cloudsql.name}"
}

resource "google_project_iam_member" "cloudsql" {
  project = "${var.project}"
  role    = "projects/${var.project}/roles/cloudsqlconnectionaccess"
  member  = "serviceAccount:${google_service_account.cloudsql.email}"
}
