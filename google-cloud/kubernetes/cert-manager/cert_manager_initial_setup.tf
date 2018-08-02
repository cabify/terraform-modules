# Run the deployment manifests https://github.com/jetstack/cert-manager/tree/master/contrib/manifests/cert-manager
data "template_file" "1_mandatory_cert_manager_namespace" {
  template = "${file("${path.module}/1_mandatory_cert_manager_namespace.yaml")}"
}

resource "k8s_manifest" "1_mandatory_cert_manager_namespace" {
  content = "${data.template_file.1_mandatory_cert_manager_namespace.rendered}"
}

data "template_file" "2_mandatory_cert_manager_service_account" {
  template = "${file("${path.module}/2_mandatory_cert_manager_service_account.yaml")}"
}

resource "k8s_manifest" "2_mandatory_cert_manager_service_account" {
  content = "${data.template_file.2_mandatory_cert_manager_service_account.rendered}"
}

data "template_file" "3_mandatory_custom_resource_definition_certificates" {
  template = "${file("${path.module}/3_mandatory_custom_resource_definition_certificates.yaml")}"
}

resource "k8s_manifest" "3_mandatory_custom_resource_definition_certificates" {
  content = "${data.template_file.3_mandatory_custom_resource_definition_certificates.rendered}"
}

data "template_file" "4_mandatory_custom_resource_definition_clusterissuers" {
  template = "${file("${path.module}/4_mandatory_custom_resource_definition_clusterissuers.yaml")}"
}

resource "k8s_manifest" "4_mandatory_custom_resource_definition_clusterissuers" {
  content = "${data.template_file.4_mandatory_custom_resource_definition_clusterissuers.rendered}"
}

data "template_file" "5_mandatory_custom_resource_definition_issuers" {
  template = "${file("${path.module}/5_mandatory_custom_resource_definition_issuers.yaml")}"
}

resource "k8s_manifest" "5_mandatory_custom_resource_definition_issuers" {
  content = "${data.template_file.5_mandatory_custom_resource_definition_issuers.rendered}"
}

data "template_file" "6_mandatory_cluster_role_cert_manager" {
  template = "${file("${path.module}/6_mandatory_cluster_role_cert_manager.yaml")}"
}

resource "k8s_manifest" "6_mandatory_cluster_role_cert_manager" {
  content = "${data.template_file.6_mandatory_cluster_role_cert_manager.rendered}"
}

data "template_file" "7_mandatory_cluster_role_binding_cert_manager" {
  template = "${file("${path.module}/7_mandatory_cluster_role_binding_cert_manager.yaml")}"
}

resource "k8s_manifest" "7_mandatory_cluster_role_binding_cert_manager" {
  content = "${data.template_file.7_mandatory_cluster_role_binding_cert_manager.rendered}"
}

data "template_file" "8_mandatory_deployment_cert_manager" {
  template = "${file("${path.module}/8_mandatory_deployment_cert_manager.yaml")}"
}

resource "k8s_manifest" "8_mandatory_deployment_cert_manager" {
  content = "${data.template_file.8_mandatory_deployment_cert_manager.rendered}"
}
