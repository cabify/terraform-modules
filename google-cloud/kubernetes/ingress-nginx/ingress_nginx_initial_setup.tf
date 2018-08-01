# Runs the mandatory manifests https://kubernetes.github.io/ingress-nginx/deploy/#mandatory-command
data "template_file" "ingress_nginx_mandatory_template_1" {
  template = "${file("${path.module}/1_mandatory_namespace.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_1" {
  content = "${data.template_file.ingress_nginx_mandatory_template_1.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_2" {
  template = "${file("${path.module}/2_mandatory_deployment_default_http_backend.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_2" {
  content = "${data.template_file.ingress_nginx_mandatory_template_2.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_3" {
  template = "${file("${path.module}/3_mandatory_service.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_3" {
  content = "${data.template_file.ingress_nginx_mandatory_template_3.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_4" {
  template = "${file("${path.module}/4_mandatory_configmap_nginx_configuration.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_4" {
  content = "${data.template_file.ingress_nginx_mandatory_template_4.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_5" {
  template = "${file("${path.module}/5_mandatory_configmap_tcp_services.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_5" {
  content = "${data.template_file.ingress_nginx_mandatory_template_5.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_6" {
  template = "${file("${path.module}/6_mandatory_configmap_udp_services.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_6" {
  content = "${data.template_file.ingress_nginx_mandatory_template_6.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_7" {
  template = "${file("${path.module}/7_mandatory_service_account_nginx.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_7" {
  content = "${data.template_file.ingress_nginx_mandatory_template_7.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_8" {
  template = "${file("${path.module}/8_mandatory_clusterrole_nginx.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_8" {
  content = "${data.template_file.ingress_nginx_mandatory_template_8.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_9" {
  template = "${file("${path.module}/9_mandatory_role_nginx.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_9" {
  content = "${data.template_file.ingress_nginx_mandatory_template_9.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_10" {
  template = "${file("${path.module}/10_mandatory_rolebinding.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_10" {
  content = "${data.template_file.ingress_nginx_mandatory_template_10.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_11" {
  template = "${file("${path.module}/11_mandatory_clusterrolebinding.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_11" {
  content = "${data.template_file.ingress_nginx_mandatory_template_11.rendered}"
}

data "template_file" "ingress_nginx_mandatory_template_12" {
  template = "${file("${path.module}/12_mandatory_deployment_ingress_nginx.yaml")}"
}

resource "k8s_manifest" "ingress_nginx_mandatory_12" {
  content = "${data.template_file.ingress_nginx_mandatory_template_12.rendered}"
}
