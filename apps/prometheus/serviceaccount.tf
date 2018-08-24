variable "rbac" {
  type = "string"

  default = <<EOF

apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: prometheus
rules:
- apiGroups: [""]
  resources:
  - nodes
  - nodes/proxy
  - services
  - endpoints
  - pods
  verbs: ["get", "list", "watch"]
- apiGroups:
  - extensions
  resources:
  - ingresses
  verbs: ["get", "list", "watch"]
- nonResourceURLs: ["/metrics"]
  verbs: ["get"]
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: prometheus
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: prometheus
subjects:
- kind: ServiceAccount
  name: prometheus
  namespace: prometheus
EOF
}

resource "kubernetes_service_account" "prometheus" {
  metadata {
    name      = "prometheus"
    namespace = "${kubernetes_namespace.prometheus.metadata.0.name}"
  }

  // There are no resources for `v1beta1` api endpoints
  //  provisioner "local-exec" {
  //    command = "cat <<EOF | kubectl --v=6 create -f - ${var.rbac}EOF"
  //  }

  //  provisioner "local-exec" {
  //    command = "cat <<EOF | kubectl --v=6 delete -f - ${var.rbac}EOF"
  //    when    = "destroy"
  //  }
}
