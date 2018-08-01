resource "google_service_account" "stackdriver" {
  // 28 char limit
  account_id   = "${substr(var.service,0,19)}-prom-sa"
  display_name = "${var.service} Service Account for Prometheus"
  project      = "${var.project}"
}

resource "google_service_account_key" "stackdriver" {
  service_account_id = "${google_service_account.stackdriver.name}"
}

resource "google_project_iam_member" "stackdriver" {
  project = "${var.project}"
  role    = "projects/${var.project}/roles/stackdriverreadaccess"
  member  = "serviceAccount:${google_service_account.stackdriver.email}"
}
