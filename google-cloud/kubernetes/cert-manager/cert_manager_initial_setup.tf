# Run the deployment manifests https://github.com/jetstack/cert-manager/releases/download/v0.9.1/cert-manager.yaml

data "template_file" "01_mandatory_cert_manager_namespace" {
  template = "${file("${path.module}/01_mandatory_cert_manager_namespace.yaml")}"
}

resource "k8s_manifest" "01_mandatory_cert_manager_namespace" {
  content = "${data.template_file.01_mandatory_cert_manager_namespace.rendered}"
}

data "template_file" "02_mandatory_custom_resource_definition_certificates" {
  template = "${file("${path.module}/02_mandatory_custom_resource_definition_certificates.yaml")}"
}

resource "k8s_manifest" "02_mandatory_custom_resource_definition_certificates" {
  content    = "${data.template_file.02_mandatory_custom_resource_definition_certificates.rendered}"
  depends_on = ["k8s_manifest.01_mandatory_cert_manager_namespace"]
}

data "template_file" "03_mandatory_custom_resource_definition_certificaterequests" {
  template = "${file("${path.module}/03_mandatory_custom_resource_definition_certificaterequests.yaml")}"
}

resource "k8s_manifest" "03_mandatory_custom_resource_definition_certificaterequests" {
  content    = "${data.template_file.03_mandatory_custom_resource_definition_certificaterequests.rendered}"
  depends_on = ["k8s_manifest.02_mandatory_custom_resource_definition_certificates"]
}

data "template_file" "04_mandatory_custom_resource_definition_challenges" {
  template = "${file("${path.module}/04_mandatory_custom_resource_definition_challenges.yaml")}"
}

resource "k8s_manifest" "04_mandatory_custom_resource_definition_challenges" {
  content    = "${data.template_file.04_mandatory_custom_resource_definition_challenges.rendered}"
  depends_on = ["k8s_manifest.03_mandatory_custom_resource_definition_certificaterequests"]
}

data "template_file" "05_mandatory_custom_resource_definition_clusterissuers" {
  template = "${file("${path.module}/05_mandatory_custom_resource_definition_clusterissuers.yaml")}"
}

resource "k8s_manifest" "05_mandatory_custom_resource_definition_clusterissuers" {
  content    = "${data.template_file.05_mandatory_custom_resource_definition_clusterissuers.rendered}"
  depends_on = ["k8s_manifest.04_mandatory_custom_resource_definition_challenges"]
}

data "template_file" "06_mandatory_custom_resource_definition_issuers" {
  template = "${file("${path.module}/06_mandatory_custom_resource_definition_issuers.yaml")}"
}

resource "k8s_manifest" "06_mandatory_custom_resource_definition_issuers" {
  content    = "${data.template_file.06_mandatory_custom_resource_definition_issuers.rendered}"
  depends_on = ["k8s_manifest.05_mandatory_custom_resource_definition_clusterissuers"]
}

data "template_file" "07_mandatory_custom_resource_definition_orders" {
  template = "${file("${path.module}/07_mandatory_custom_resource_definition_orders.yaml")}"
}

resource "k8s_manifest" "07_mandatory_custom_resource_definition_orders" {
  content    = "${data.template_file.07_mandatory_custom_resource_definition_orders.rendered}"
  depends_on = ["k8s_manifest.06_mandatory_custom_resource_definition_issuers"]
}

data "template_file" "08_mandatory_service_account_cainjector" {
  template = "${file("${path.module}/08_mandatory_service_account_cainjector.yaml")}"
}

resource "k8s_manifest" "08_mandatory_service_account_cainjector" {
  content    = "${data.template_file.08_mandatory_service_account_cainjector.rendered}"
  depends_on = ["k8s_manifest.07_mandatory_custom_resource_definition_orders"]
}

data "template_file" "09_mandatory_service_account_webhook" {
  template = "${file("${path.module}/09_mandatory_service_account_webhook.yaml")}"
}

resource "k8s_manifest" "09_mandatory_service_account_webhook" {
  content    = "${data.template_file.09_mandatory_service_account_webhook.rendered}"
  depends_on = ["k8s_manifest.08_mandatory_service_account_cainjector"]
}

data "template_file" "10_mandatory_service_account_cert_manager" {
  template = "${file("${path.module}/10_mandatory_service_account_cert_manager.yaml")}"
}

resource "k8s_manifest" "10_mandatory_service_account_cert_manager" {
  content    = "${data.template_file.10_mandatory_service_account_cert_manager.rendered}"
  depends_on = ["k8s_manifest.09_mandatory_service_account_webhook"]
}

data "template_file" "11_mandatory_cluster_role_cainjector" {
  template = "${file("${path.module}/11_mandatory_cluster_role_cainjector.yaml")}"
}

resource "k8s_manifest" "11_mandatory_cluster_role_cainjector" {
  content    = "${data.template_file.11_mandatory_cluster_role_cainjector.rendered}"
  depends_on = ["k8s_manifest.10_mandatory_service_account_cert_manager"]
}

data "template_file" "12_mandatory_cluster_role_binding_cainjector" {
  template = "${file("${path.module}/12_mandatory_cluster_role_binding_cainjector.yaml")}"
}

resource "k8s_manifest" "12_mandatory_cluster_role_binding_cainjector" {
  content    = "${data.template_file.12_mandatory_cluster_role_binding_cainjector.rendered}"
  depends_on = ["k8s_manifest.11_mandatory_cluster_role_cainjector"]
}

data "template_file" "13_mandatory_cluster_role_leaderelection" {
  template = "${file("${path.module}/13_mandatory_cluster_role_leaderelection.yaml")}"
}

resource "k8s_manifest" "13_mandatory_cluster_role_leaderelection" {
  content    = "${data.template_file.13_mandatory_cluster_role_leaderelection.rendered}"
  depends_on = ["k8s_manifest.12_mandatory_cluster_role_binding_cainjector"]
}

data "template_file" "14_mandatory_cluster_role_controller_issuers" {
  template = "${file("${path.module}/14_mandatory_cluster_role_controller_issuers.yaml")}"
}

resource "k8s_manifest" "14_mandatory_cluster_role_controller_issuers" {
  content    = "${data.template_file.14_mandatory_cluster_role_controller_issuers.rendered}"
  depends_on = ["k8s_manifest.13_mandatory_cluster_role_leaderelection"]
}

data "template_file" "15_mandatory_cluster_role_controller_clusterissuers" {
  template = "${file("${path.module}/15_mandatory_cluster_role_controller_clusterissuers.yaml")}"
}

resource "k8s_manifest" "15_mandatory_cluster_role_controller_clusterissuers" {
  content    = "${data.template_file.15_mandatory_cluster_role_controller_clusterissuers.rendered}"
  depends_on = ["k8s_manifest.14_mandatory_cluster_role_controller_issuers"]
}

data "template_file" "16_mandatory_cluster_role_controller_certificates" {
  template = "${file("${path.module}/16_mandatory_cluster_role_controller_certificates.yaml")}"
}

resource "k8s_manifest" "16_mandatory_cluster_role_controller_certificates" {
  content    = "${data.template_file.16_mandatory_cluster_role_controller_certificates.rendered}"
  depends_on = ["k8s_manifest.15_mandatory_cluster_role_controller_clusterissuers"]
}

data "template_file" "17_mandatory_cluster_role_controller_orders" {
  template = "${file("${path.module}/17_mandatory_cluster_role_controller_orders.yaml")}"
}

resource "k8s_manifest" "17_mandatory_cluster_role_controller_orders" {
  content    = "${data.template_file.17_mandatory_cluster_role_controller_orders.rendered}"
  depends_on = ["k8s_manifest.16_mandatory_cluster_role_controller_certificates"]
}

data "template_file" "18_mandatory_cluster_role_controller_challenges" {
  template = "${file("${path.module}/18_mandatory_cluster_role_controller_challenges.yaml")}"
}

resource "k8s_manifest" "18_mandatory_cluster_role_controller_challenges" {
  content    = "${data.template_file.18_mandatory_cluster_role_controller_challenges.rendered}"
  depends_on = ["k8s_manifest.17_mandatory_cluster_role_controller_orders"]
}

data "template_file" "19_mandatory_cluster_role_controller_ingress_shim" {
  template = "${file("${path.module}/19_mandatory_cluster_role_controller_ingress_shim.yaml")}"
}

resource "k8s_manifest" "19_mandatory_cluster_role_controller_ingress_shim" {
  content    = "${data.template_file.19_mandatory_cluster_role_controller_ingress_shim.rendered}"
  depends_on = ["k8s_manifest.18_mandatory_cluster_role_controller_challenges"]
}

data "template_file" "20_mandatory_cluster_role_binding_leaderelection" {
  template = "${file("${path.module}/20_mandatory_cluster_role_binding_leaderelection.yaml")}"
}

resource "k8s_manifest" "20_mandatory_cluster_role_binding_leaderelection" {
  content    = "${data.template_file.20_mandatory_cluster_role_binding_leaderelection.rendered}"
  depends_on = ["k8s_manifest.19_mandatory_cluster_role_controller_ingress_shim"]
}

data "template_file" "21_mandatory_cluster_role_binding_controller_issuers" {
  template = "${file("${path.module}/21_mandatory_cluster_role_binding_controller_issuers.yaml")}"
}

resource "k8s_manifest" "21_mandatory_cluster_role_binding_controller_issuers" {
  content    = "${data.template_file.21_mandatory_cluster_role_binding_controller_issuers.rendered}"
  depends_on = ["k8s_manifest.20_mandatory_cluster_role_binding_leaderelection"]
}

data "template_file" "22_mandatory_cluster_role_binding_controller_clusterissuers" {
  template = "${file("${path.module}/22_mandatory_cluster_role_binding_controller_clusterissuers.yaml")}"
}

resource "k8s_manifest" "22_mandatory_cluster_role_binding_controller_clusterissuers" {
  content    = "${data.template_file.22_mandatory_cluster_role_binding_controller_clusterissuers.rendered}"
  depends_on = ["k8s_manifest.21_mandatory_cluster_role_binding_controller_issuers"]
}

data "template_file" "23_mandatory_cluster_role_binding_controller_certificates" {
  template = "${file("${path.module}/23_mandatory_cluster_role_binding_controller_certificates.yaml")}"
}

resource "k8s_manifest" "23_mandatory_cluster_role_binding_controller_certificates" {
  content    = "${data.template_file.23_mandatory_cluster_role_binding_controller_certificates.rendered}"
  depends_on = ["k8s_manifest.22_mandatory_cluster_role_binding_controller_clusterissuers"]
}

data "template_file" "24_mandatory_cluster_role_binding_controller_orders" {
  template = "${file("${path.module}/24_mandatory_cluster_role_binding_controller_orders.yaml")}"
}

resource "k8s_manifest" "24_mandatory_cluster_role_binding_controller_orders" {
  content    = "${data.template_file.24_mandatory_cluster_role_binding_controller_orders.rendered}"
  depends_on = ["k8s_manifest.23_mandatory_cluster_role_binding_controller_certificates"]
}

data "template_file" "25_mandatory_cluster_role_binding_controller_challenges" {
  template = "${file("${path.module}/25_mandatory_cluster_role_binding_controller_challenges.yaml")}"
}

resource "k8s_manifest" "25_mandatory_cluster_role_binding_controller_challenges" {
  content    = "${data.template_file.25_mandatory_cluster_role_binding_controller_challenges.rendered}"
  depends_on = ["k8s_manifest.24_mandatory_cluster_role_binding_controller_orders"]
}

data "template_file" "26_mandatory_cluster_role_binding_controller_ingress_shim" {
  template = "${file("${path.module}/26_mandatory_cluster_role_binding_controller_ingress_shim.yaml")}"
}

resource "k8s_manifest" "26_mandatory_cluster_role_binding_controller_ingress_shim" {
  content    = "${data.template_file.26_mandatory_cluster_role_binding_controller_ingress_shim.rendered}"
  depends_on = ["k8s_manifest.25_mandatory_cluster_role_binding_controller_challenges"]
}

data "template_file" "27_mandatory_cluster_role_view" {
  template = "${file("${path.module}/27_mandatory_cluster_role_view.yaml")}"
}

resource "k8s_manifest" "27_mandatory_cluster_role_view" {
  content    = "${data.template_file.27_mandatory_cluster_role_view.rendered}"
  depends_on = ["k8s_manifest.26_mandatory_cluster_role_binding_controller_ingress_shim"]
}

data "template_file" "28_mandatory_cluster_role_edit" {
  template = "${file("${path.module}/28_mandatory_cluster_role_edit.yaml")}"
}

resource "k8s_manifest" "28_mandatory_cluster_role_edit" {
  content    = "${data.template_file.28_mandatory_cluster_role_edit.rendered}"
  depends_on = ["k8s_manifest.27_mandatory_cluster_role_view"]
}

data "template_file" "29_mandatory_cluster_role_binding_webhook" {
  template = "${file("${path.module}/29_mandatory_cluster_role_binding_webhook.yaml")}"
}

resource "k8s_manifest" "29_mandatory_cluster_role_binding_webhook" {
  content    = "${data.template_file.29_mandatory_cluster_role_binding_webhook.rendered}"
  depends_on = ["k8s_manifest.28_mandatory_cluster_role_edit"]
}

data "template_file" "30_mandatory_role_binding_webhook" {
  template = "${file("${path.module}/30_mandatory_role_binding_webhook.yaml")}"
}

resource "k8s_manifest" "30_mandatory_role_binding_webhook" {
  content    = "${data.template_file.30_mandatory_role_binding_webhook.rendered}"
  depends_on = ["k8s_manifest.29_mandatory_cluster_role_binding_webhook"]
}

data "template_file" "31_mandatory_cluster_role_webhook" {
  template = "${file("${path.module}/31_mandatory_cluster_role_webhook.yaml")}"
}

resource "k8s_manifest" "31_mandatory_cluster_role_webhook" {
  content    = "${data.template_file.31_mandatory_cluster_role_webhook.rendered}"
  depends_on = ["k8s_manifest.30_mandatory_role_binding_webhook"]
}

data "template_file" "32_mandatory_service_cert_manager" {
  template = "${file("${path.module}/32_mandatory_service_cert_manager.yaml")}"
}

resource "k8s_manifest" "32_mandatory_service_cert_manager" {
  content    = "${data.template_file.32_mandatory_service_cert_manager.rendered}"
  depends_on = ["k8s_manifest.31_mandatory_cluster_role_webhook"]
}

data "template_file" "33_mandatory_deployment_cainjector" {
  template = "${file("${path.module}/33_mandatory_deployment_cainjector.yaml")}"
}

resource "k8s_manifest" "33_mandatory_deployment_cainjector" {
  content    = "${data.template_file.33_mandatory_deployment_cainjector.rendered}"
  depends_on = ["k8s_manifest.32_mandatory_service_cert_manager"]
}

data "template_file" "34_mandatory_deployment_webhook" {
  template = "${file("${path.module}/34_mandatory_deployment_webhook.yaml")}"
}

resource "k8s_manifest" "34_mandatory_deployment_webhook" {
  content    = "${data.template_file.34_mandatory_deployment_webhook.rendered}"
  depends_on = ["k8s_manifest.33_mandatory_deployment_cainjector"]
}

data "template_file" "35_mandatory_deployment_cert_manager" {
  template = "${file("${path.module}/35_mandatory_deployment_cert_manager.yaml")}"
}

resource "k8s_manifest" "35_mandatory_deployment_cert_manager" {
  content    = "${data.template_file.35_mandatory_deployment_cert_manager.rendered}"
  depends_on = ["k8s_manifest.34_mandatory_deployment_webhook"]
}

data "template_file" "36_mandatory_apiservice" {
  template = "${file("${path.module}/36_mandatory_apiservice.yaml")}"
}

resource "k8s_manifest" "36_mandatory_apiservice" {
  content    = "${data.template_file.36_mandatory_apiservice.rendered}"
  depends_on = ["k8s_manifest.35_mandatory_deployment_cert_manager"]
}

data "template_file" "37_mandatory_issuer_webhook_selfsign" {
  template = "${file("${path.module}/37_mandatory_issuer_webhook_selfsign.yaml")}"
}

resource "k8s_manifest" "37_mandatory_issuer_webhook_selfsign" {
  content    = "${data.template_file.37_mandatory_issuer_webhook_selfsign.rendered}"
  depends_on = ["k8s_manifest.36_mandatory_apiservice"]
}

data "template_file" "38_mandatory_certificate_webhook_ca" {
  template = "${file("${path.module}/38_mandatory_certificate_webhook_ca.yaml")}"
}

resource "k8s_manifest" "38_mandatory_certificate_webhook_ca" {
  content    = "${data.template_file.38_mandatory_certificate_webhook_ca.rendered}"
  depends_on = ["k8s_manifest.37_mandatory_issuer_webhook_selfsign"]
}

data "template_file" "39_mandatory_issuer_webhook_ca" {
  template = "${file("${path.module}/39_mandatory_issuer_webhook_ca.yaml")}"
}

resource "k8s_manifest" "39_mandatory_issuer_webhook_ca" {
  content    = "${data.template_file.39_mandatory_issuer_webhook_ca.rendered}"
  depends_on = ["k8s_manifest.38_mandatory_certificate_webhook_ca"]
}

data "template_file" "40_mandatory_certificate_webhook_tls" {
  template = "${file("${path.module}/40_mandatory_certificate_webhook_tls.yaml")}"
}

resource "k8s_manifest" "40_mandatory_certificate_webhook_tls" {
  content    = "${data.template_file.40_mandatory_certificate_webhook_tls.rendered}"
  depends_on = ["k8s_manifest.39_mandatory_issuer_webhook_ca"]
}

data "template_file" "41_mandatory_validating_webhook_configuration" {
  template = "${file("${path.module}/41_mandatory_validating_webhook_configuration.yaml")}"
}

resource "k8s_manifest" "41_mandatory_validating_webhook_configuration" {
  content    = "${data.template_file.41_mandatory_validating_webhook_configuration.rendered}"
  depends_on = ["k8s_manifest.40_mandatory_certificate_webhook_tls"]
}
