data "template_file" "prometheus_config" {
  template = "${file("${path.module}/files/prometheus.yaml")}"

  vars {
    consul_address    = "${var.consul_address}"
    consul_datacenter = "${var.consul_datacenter}"
  }
}

resource "kubernetes_config_map" "prometheus" {
  metadata {
    name      = "prometheus-configuration"
    namespace = "${kubernetes_namespace.prometheus.metadata.0.name}"
  }

  data {
    prometheus.yml = "${data.template_file.prometheus_config.rendered}"
  }
}

data "template_file" "alertrules" {
  template = "${file("${path.module}/files/config-map-alertrules.yaml")}"

  vars {
    namespace = "${kubernetes_namespace.prometheus.metadata.0.name}"
  }
}

resource "k8s_manifest" "alertrules" {
  content    = "${data.template_file.alertrules.rendered}"
  depends_on = ["kubernetes_config_map.prometheus"]
}

data "template_file" "recordingrules" {
  template = "${file("${path.module}/files/config-map-recordingrules.yaml")}"

  vars {
    namespace = "${kubernetes_namespace.prometheus.metadata.0.name}"
  }
}

resource "k8s_manifest" "recordingrules" {
  content    = "${data.template_file.recordingrules.rendered}"
  depends_on = ["kubernetes_config_map.prometheus"]
}
