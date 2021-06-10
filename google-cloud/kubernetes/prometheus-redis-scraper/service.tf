resource "kubernetes_service" "redis" {
  metadata {
    annotations = {
      prometheus_io_scrape      = "persistence"
      prometheus_io_environment = replace(var.project, "cabify-", "")
      prometheus_io_service     = var.service
      prometheus_io_ownder      = var.owner
      prometheus_io_tier        = var.tier
      prometheus_io_placement   = "redislabs"
      prometheus_io_size        = var.size
      prometheus_io_evictions   = var.eviction
    }

    name      = kubernetes_replication_controller.redis.metadata[0].name
    namespace = var.namespace
  }
  wait_for_load_balancer = true
  spec {
    selector = {
      app = kubernetes_replication_controller.redis.metadata[0].labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = var.container_port
      target_port = var.container_port
    }

    type = "ClusterIP"
  }
}

