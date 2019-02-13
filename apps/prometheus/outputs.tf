###############################################################################
## Module outputs
###############################################################################
output "prometheus_service_name" {
  value = "${kubernetes_service.prometheus.metadata.0.name}"
}

output "prometheus_service_port" {
  value = "${var.prometheus-port}"
}

output "prometheus_namespace" {
  value = "${kubernetes_namespace.prometheus.metadata.0.name}"
}

output "trickster_service_name" {
  value = "${kubernetes_service.trickster.metadata.0.name}"
}

output "trickster_service_port" {
  value = "${var.trickster_port}"
}