variable "rbac" {
  type = "string"

  default = <<EOF

apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: prometheus-server
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
  name: prometheus-server
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: prometheus-server
subjects:
- kind: ServiceAccount
  name: prometheus-server
  namespace: prometheus-scrapers
EOF
}

resource "kubernetes_service_account" "prometheus-server-kubernetes_service_account" {
  metadata {
    name      = "prometheus-server"
    namespace = "${kubernetes_namespace.prometheus-scrapers.metadata.0.name}"
  }

  // There are no resources for `v1beta1` api endpoints
  provisioner "local-exec" {
    command = "cat <<EOF | kubectl create -f - ${var.rbac}EOF"
  }

  provisioner "local-exec" {
    command = "cat <<EOF | kubectl delete -f - ${var.rbac}EOF"
    when    = "destroy"
  }
}
