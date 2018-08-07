data "template_file" "external-endpoint" {
  template = <<EOF
kind: Endpoints
apiVersion: v1
metadata:
  name: $${name}
  namespace: $${namespace}
  annotations:
    fqdn: $${fqdn}
subsets:
  - addresses:
      - ip: $${ipaddress}
    ports:
      - port: $${port}
EOF

  vars {
    name      = "${var.name}"
    namespace = "${var.namespace}"
    port      = "${var.port}"
    ipaddress = "${var.ipaddress}"
    fqdn      = "${var.fqdn}"
  }
}

resource "k8s_manifest" "external-endpoint" {
  content = "${data.template_file.external-endpoint.rendered}"
}
