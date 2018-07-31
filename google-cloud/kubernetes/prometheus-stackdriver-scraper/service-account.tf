resource "google_service_account" "stackdriver" {
  account_id   = "${var.service}-account"
  display_name = "${var.service} Service Account"
  project      = "${var.project}"
}

resource "google_service_account_key" "stackdriver" {
  service_account_id = "${google_service_account.stackdriver.name}"
}
