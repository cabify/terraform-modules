resource "kubernetes_service" "cloudsql" {
  metadata {
    annotations {
      prometheus_io_scrape        = "persistence"
      prometheus_io_environment   = "${replace("${replace(var.project,"cabify-","")}","-cloudsql-1","")}"
      prometheus_io_service       = "${var.service_name}"
      prometheus_io_owner         = "${var.owner}"
      prometheus_io_tier          = "${var.tier}"
      prometheus_io_instance_tier = "${var.instance_tier}"
    }

    name      = "${kubernetes_replication_controller.cloudsql.metadata.0.name}"
    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "${kubernetes_replication_controller.cloudsql.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 9104
      target_port = 9104
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "cloudsql-failover" {
  count = "${var.instance_read_only_replica_count}"

  metadata {
    annotations {
      prometheus_io_scrape        = "persistence"
      prometheus_io_environment   = "${replace(var.project,"cabify-","")}"
      prometheus_io_service       = "${var.service_name}"
      prometheus_io_owner         = "${var.owner}"
      prometheus_io_tier          = "${var.tier}"
      prometheus_io_instance_tier = "${var.instance_tier_read_only_replica == "UNSET" ? var.instance_tier : var.instance_tier_read_only_replica}"
    }

    name      = "${element(kubernetes_replication_controller.cloudsql-failover.*.metadata.0.name, count.index)}"
    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "${element(kubernetes_replication_controller.cloudsql-failover.*.metadata.0.labels.app, count.index)}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 9104
      target_port = 9104
    }

    type = "ClusterIP"
  }
}
