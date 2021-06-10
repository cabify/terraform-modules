# Run the deployment manifests https://github.com/jetstack/cert-manager/tree/master/contrib/manifests/cert-manager
data "template_file" "_1_mandatory_cert_manager_namespace" {
  template = file("${path.module}/1_mandatory_cert_manager_namespace.yaml")
}

resource "k8s_manifest" "_1_mandatory_cert_manager_namespace" {
  content = data.template_file._1_mandatory_cert_manager_namespace.rendered
}

data "template_file" "_2_mandatory_cert_manager_service_account" {
  template = file("${path.module}/2_mandatory_cert_manager_service_account.yaml")
}

resource "k8s_manifest" "_2_mandatory_cert_manager_service_account" {
  content    = data.template_file._2_mandatory_cert_manager_service_account.rendered
  depends_on = [k8s_manifest._1_mandatory_cert_manager_namespace]
}

data "template_file" "_3_mandatory_custom_resource_definition_certificates" {
  template = file("${path.module}/3_mandatory_custom_resource_definition_certificates.yaml")
}

resource "k8s_manifest" "_3_mandatory_custom_resource_definition_certificates" {
  content    = data.template_file._3_mandatory_custom_resource_definition_certificates.rendered
  depends_on = [k8s_manifest._2_mandatory_cert_manager_service_account]
}

data "template_file" "_4_mandatory_custom_resource_definition_clusterissuers" {
  template = file("${path.module}/4_mandatory_custom_resource_definition_clusterissuers.yaml")
}

resource "k8s_manifest" "_4_mandatory_custom_resource_definition_clusterissuers" {
  content    = data.template_file._4_mandatory_custom_resource_definition_clusterissuers.rendered
  depends_on = [k8s_manifest._3_mandatory_custom_resource_definition_certificates]
}

data "template_file" "_5_mandatory_custom_resource_definition_issuers" {
  template = file("${path.module}/5_mandatory_custom_resource_definition_issuers.yaml")
}

resource "k8s_manifest" "_5_mandatory_custom_resource_definition_issuers" {
  content    = data.template_file._5_mandatory_custom_resource_definition_issuers.rendered
  depends_on = [k8s_manifest._4_mandatory_custom_resource_definition_clusterissuers]
}

data "template_file" "_6_mandatory_cluster_role_cert_manager" {
  template = file("${path.module}/6_mandatory_cluster_role_cert_manager.yaml")
}

resource "k8s_manifest" "_6_mandatory_cluster_role_cert_manager" {
  content    = data.template_file._6_mandatory_cluster_role_cert_manager.rendered
  depends_on = [k8s_manifest._5_mandatory_custom_resource_definition_issuers]
}

data "template_file" "_7_mandatory_cluster_role_binding_cert_manager" {
  template = file("${path.module}/7_mandatory_cluster_role_binding_cert_manager.yaml")
}

resource "k8s_manifest" "_7_mandatory_cluster_role_binding_cert_manager" {
  content    = data.template_file._7_mandatory_cluster_role_binding_cert_manager.rendered
  depends_on = [k8s_manifest._6_mandatory_cluster_role_cert_manager]
}

data "template_file" "_8_mandatory_deployment_cert_manager" {
  template = file("${path.module}/8_mandatory_deployment_cert_manager.yaml")
}

resource "k8s_manifest" "_8_mandatory_deployment_cert_manager" {
  content    = data.template_file._8_mandatory_deployment_cert_manager.rendered
  depends_on = [k8s_manifest._7_mandatory_cluster_role_binding_cert_manager]
}
