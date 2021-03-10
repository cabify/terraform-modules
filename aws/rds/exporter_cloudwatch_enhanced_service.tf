resource "kubernetes_service" "cloudwatch-primary-enhanced" {
  count = var.cloudwatch_enhanced_enabled ? 1 : 0
  metadata {
    annotations = {
      prometheus_io_scrape        = var.prometheus-scrape-flag
      prometheus_io_environment   = replace(var.aws_account, "cabify-", "")
      prometheus_io_service       = var.service_name == "UNSET" ? var.instance_name : var.service_name
      prometheus_io_owner         = var.owner
      prometheus_io_tier          = var.tier
      prometheus_io_instance_tier = var.instance_class
      prometheus_io_path          = "/enhanced"
    }

    name      = kubernetes_deployment.cloudwatch-enhanced[0].metadata[0].name
    namespace = var.namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.cloudwatch[0].metadata[0].labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = 9042
      target_port = 9042
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "cloudwatch-read-replica-enhanced" {
  count = var.cloudwatch_enhanced_enabled ? var.read_only_replicas : 0
  metadata {
    annotations = {
      prometheus_io_scrape        = var.prometheus-scrape-flag
      prometheus_io_environment   = replace(var.aws_account, "cabify-", "")
      prometheus_io_service       = var.service_name == "UNSET" ? var.instance_name : var.service_name
      prometheus_io_owner         = var.owner
      prometheus_io_tier          = var.tier
      prometheus_io_instance_tier = var.instance_class
      prometheus_io_path          = "/enhanced"
    }

    name      = element(kubernetes_deployment.cloudwatch-read-only-enhanced.*.metadata.0.name, count.index)
    namespace = var.namespace
  }

  spec {
    selector = {
      app = element(kubernetes_deployment.cloudwatch-read-only-enhanced.*.metadata.0.labels.app, count.index)
    }

    session_affinity = "ClientIP"

    port {
      port        = 9042
      target_port = 9042
    }

    type = "ClusterIP"
  }
}
