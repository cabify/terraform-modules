resource "kubernetes_config_map" "prometheus" {
  metadata {
    name      = "prometheus-configuration"
    namespace = "${kubernetes_namespace.prometheus.metadata.0.name}"
  }

  data {
    prometheus.yml = "${file("${path.module}/files/prometheus.yaml")}"
  }
}

data "template_file" "alertrules" {
  template = "${file("${path.module}/files/config-map-alertrules.yaml")}"
}

resource "k8s_manifest" "alertrules" {
  content    = "${data.template_file.alertrules.rendered}"
  depends_on = ["kubernetes_config_map.prometheus"]
}

data "template_file" "recordingrules" {
  template = "${file("${path.module}/files/config-map-recordingrules.yaml")}"
}

resource "k8s_manifest" "recordingrules" {
  content    = "${data.template_file.recordingrules.rendered}"
  depends_on = ["kubernetes_config_map.prometheus"]
}
