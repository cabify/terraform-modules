resource "kubernetes_service_account" "prometheus" {
  metadata {
    name      = kubernetes_namespace.prometheus.metadata.0.name
    namespace = kubernetes_namespace.prometheus.metadata.0.name
  }
}

data "template_file" "clusterrole" {
  template = file("${path.module}/files/clusterrole.yaml")

  vars = {
    namespace = kubernetes_namespace.prometheus.metadata.0.name
  }
}

resource "k8s_manifest" "clusterrole" {
  content    = data.template_file.clusterrole.rendered
  depends_on = [kubernetes_service_account.prometheus]
}

data "template_file" "clusterrolebinding" {
  template = file("${path.module}/files/clusterrolebinding.yaml")

  vars = {
    namespace = kubernetes_namespace.prometheus.metadata.0.name
  }
}

resource "k8s_manifest" "clusterrolebinding" {
  content    = data.template_file.clusterrolebinding.rendered
  depends_on = [kubernetes_service_account.prometheus]
}
