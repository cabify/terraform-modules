resource "google_container_node_pool" "gke-prometheus" {
  name               = "gke-prometheus"
  zone               = "${var.gc_zone}"
  cluster            = "${var.gc_project}"
  initial_node_count = 3

  autoscaling {
    min_node_count = 0
    max_node_count = 5
  }

  node_config {
    preemptible  = true
    machine_type = "n1-standard-2"

    oauth_scopes = [
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring",
    ]
  }
}
