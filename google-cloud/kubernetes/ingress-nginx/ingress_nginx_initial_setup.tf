# Run the mandatory manifests https://kubernetes.github.io/ingress-nginx/deploy/#mandatory-command
resource "null_resource" "ingress_nginx_mandatory_setup" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml"
  }
}
