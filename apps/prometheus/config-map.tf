variable "configmaps" {
  type = "string"

  default = <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: alertrules
  namespace: prometheus
data:
  placeholder: /
    empty
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: recordingrules 
  namespace: prometheus
data:
  placeholder: /
    empty
EOF
}

resource "kubernetes_config_map" "prometheus-config-map" {
  metadata {
    name      = "prometheus-configuration"
    namespace = "${kubernetes_namespace.prometheus.metadata.0.name}"
  }

  data {
    prometheus.yml = "${file("${path.module}/files/prometheus.yaml")}"
  }

  // Create empty configmaps to be filled by CI
  provisioner "local-exec" {
    command = "cat <<EOF | kubectl create -f - ${var.configmaps}EOF"
  }

  provisioner "local-exec" {
    command = "cat <<EOF | kubectl delete -f - ${var.configmaps}EOF"
    when    = "destroy"
  }
}
