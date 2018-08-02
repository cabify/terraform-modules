# In this file we need to make use of the terraform k8s community provider
# because the official kubernetes provider does not provide the necessary
# resources for Kubernetes ClusterIssuers.

# This file will generate the clusterissues for letsencrypt that will be
# available cluster wide.
data "template_file" "issuer" {
  template = "${file("${path.module}/cluster_issuers_template.yaml")}"

  vars {
    email                  = "${var.letsencrypt_email}"
    cluster_issuer_prod    = "${var.letsencrypt_prod_issuer_name}"
    cluster_issuer_staging = "${var.letsencrypt_staging_issuer_name}"
  }
}

resource "k8s_manifest" "issuer" {
  content = "${data.template_file.issuer.rendered}"
}
