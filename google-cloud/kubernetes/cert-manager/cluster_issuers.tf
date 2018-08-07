# In this file we need to make use of the terraform k8s community provider
# because the official kubernetes provider does not provide the necessary
# resources for Kubernetes ClusterIssuers.

# This file will generate the clusterissues for letsencrypt that will be
# available cluster wide.
data "template_file" "issuer_staging" {
  template = "${file("${path.module}/cluster_issuers_template.yaml")}"

  vars {
    email               = "${var.letsencrypt_email}"
    cluster_issuer_name = "${var.letsencrypt_staging_issuer_name}"
    server              = "https://acme-staging-v02.api.letsencrypt.org/directory"
  }
}

resource "k8s_manifest" "issuer_staging" {
  content    = "${data.template_file.issuer_staging.rendered}"
  depends_on = ["k8s_manifest.8_mandatory_deployment_cert_manager"]
}

data "template_file" "issuer_production" {
  template = "${file("${path.module}/cluster_issuers_template.yaml")}"

  vars {
    email               = "${var.letsencrypt_email}"
    cluster_issuer_name = "${var.letsencrypt_prod_issuer_name}"
    server              = "https://acme-v02.api.letsencrypt.org/directory"
  }
}

resource "k8s_manifest" "issuer_production" {
  content    = "${data.template_file.issuer_production.rendered}"
  depends_on = ["k8s_manifest.8_mandatory_deployment_cert_manager"]
}
