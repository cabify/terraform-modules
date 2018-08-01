resource "google_service_account" "cloudsql" {
  // 30 char limit - md5 so we dont have collisions
  account_id   = "prom-sa-${format("%.19s", md5(var.service_name))}"
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
