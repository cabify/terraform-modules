resource "google_service_account" "stackdriver" {
  // 30 char limit - md5 so we dont have collisions
  account_id   = "${format("%.19s", md5(var.service_name))}-prom-sa"
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
