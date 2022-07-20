resource "kubernetes_service" "primary" {
  metadata {
    annotations = {
      prometheus_io_scrape        = var.prometheus-scrape-flag
      prometheus_io_environment   = replace(var.aws_account, "cabify-", "")
      prometheus_io_service       = var.service_name == "UNSET" ? var.instance_name : var.service_name
      prometheus_io_owner         = var.owner
      prometheus_io_tier          = var.tier
      prometheus_io_instance_tier = var.instance_class
    }

    labels = {
      app = kubernetes_deployment.rds.metadata[0].labels.app
      owner = var.owner
      tier = var.tier
      ssot = "persistence-tf"
    }

    name      = kubernetes_deployment.rds.metadata[0].name
    namespace = var.namespace
  }

  wait_for_load_balancer = true

  spec {
    selector = {
      app = kubernetes_deployment.rds.metadata[0].labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = 9104
      target_port = 9104
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "read-replica" {
  count = var.read_only_replicas

  metadata {
    annotations = {
      prometheus_io_scrape        = var.prometheus-scrape-flag
      prometheus_io_environment   = replace(var.aws_account, "cabify-", "")
      prometheus_io_service       = var.service_name == "UNSET" ? var.instance_name : var.service_name
      prometheus_io_owner         = var.owner
      prometheus_io_tier          = var.tier
      prometheus_io_instance_tier = var.read_only_replica_instance_class == "UNSET" ? var.instance_class : var.read_only_replica_instance_class
    }

    labels = {
      app = element(
        kubernetes_deployment.rds-read-only.*.metadata.0.labels.app,
        count.index,
      )
      owner = var.owner
      tier = var.tier
      ssot = "persistence-tf"
    }
    name = element(
      kubernetes_deployment.rds-read-only.*.metadata.0.name,
      count.index,
    )
    namespace = var.namespace
  }

  spec {
    selector = {
      app = element(
        kubernetes_deployment.rds-read-only.*.metadata.0.labels.app,
        count.index,
      )
      owner = var.owner
      tier = var.tier
    }

    session_affinity = "ClientIP"

    port {
      port        = 9104
      target_port = 9104
    }

    type = "ClusterIP"
  }
}
