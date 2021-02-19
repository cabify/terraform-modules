resource "kubernetes_service" "cloudwatch-primary-basic" {
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

    name      = "${kubernetes_deployment.cloudwatch.metadata[0].name}-basic"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.cloudwatch.metadata[0].labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = 9042
      target_port = 9042
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "cloudwatch-primary-enhanced" {
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

    name      = "${kubernetes_deployment.cloudwatch.metadata[0].name}-enhanced"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.cloudwatch.metadata[0].labels.app
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
  count = var.read_only_replicas
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
      app = kubernetes_deployment.rds.metadata[0].labels.app
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
  count = var.read_only_replicas
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

    name      = "${element(kubernetes_deployment.cloudwatch-read-only.*.metadata.0.name, count.index)}-enhanced"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.rds.metadata[0].labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = 9042
      target_port = 9042
    }

    type = "ClusterIP"
  }
}
