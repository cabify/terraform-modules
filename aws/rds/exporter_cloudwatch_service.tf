resource "kubernetes_service" "cloudwatch-primary-basic" {
  count = var.cloudwatch_enabled ? 1 : 0
  metadata {
    annotations = {
      prometheus_io_scrape        = var.prometheus-scrape-flag
      prometheus_io_environment   = replace(var.aws_account, "cabify-", "")
      prometheus_io_service       = var.service_name == "UNSET" ? var.instance_name : var.service_name
      prometheus_io_owner         = var.owner
      prometheus_io_tier          = var.tier
      prometheus_io_instance_tier = var.instance_class
      prometheus_io_path          = "/basic"
    }

    name      = "${kubernetes_deployment.cloudwatch.0.metadata.0.name}-basic"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.cloudwatch.0.metadata.0.labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = 9042
      target_port = 9042
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "cloudwatch-read-replica-basic" {
  count = var.cloudwatch_enabled ? var.read_only_replicas : 0
  metadata {
    annotations = {
      prometheus_io_scrape        = var.prometheus-scrape-flag
      prometheus_io_environment   = replace(var.aws_account, "cabify-", "")
      prometheus_io_service       = var.service_name == "UNSET" ? var.instance_name : var.service_name
      prometheus_io_owner         = var.owner
      prometheus_io_tier          = var.tier
      prometheus_io_instance_tier = var.read_only_replica_instance_class == "unset" ? var.instance_class : var.read_only_replica_instance_class
      prometheus_io_path          = "/basic"
    }

    name      = "${element(kubernetes_deployment.cloudwatch-read-only.*.metadata.0.name, count.index)}-basic"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = element(kubernetes_deployment.cloudwatch-read-only.*.metadata.0.labels.app, count.index)
    }

    session_affinity = "ClientIP"

    port {
      port        = 9042
      target_port = 9042
    }

    type = "ClusterIP"
  }
}
