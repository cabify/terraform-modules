resource "kubernetes_service" "sql_exporter" {
  count = var.sql_exporter_enabled ? 1 : 0
  metadata {
    annotations = {
      prometheus_io_scrape        = var.prometheus-scrape-flag
      prometheus_io_environment   = replace(var.aws_account, "cabify-", "")
      prometheus_io_service       = var.service_name == "UNSET" ? var.instance_name : var.service_name
      prometheus_io_owner         = var.owner
      prometheus_io_tier          = var.tier
      prometheus_io_instance_tier = var.instance_class
      prometheus_io_path          = "/metrics"
    }

    labels = {
      app = kubernetes_deployment.sql_exporter.0.metadata.0.labels.app
      owner = var.owner
      tier = var.tier
      ssot = "persistence-tf"
    }
    
    name      = kubernetes_deployment.sql_exporter.0.metadata.0.name
    namespace = var.namespace
  }

  wait_for_load_balancer = true

  spec {
    selector = {
      app = kubernetes_deployment.sql_exporter.0.metadata.0.labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = 9399
      target_port = 9399
    }

    type = "ClusterIP"
  }
}
