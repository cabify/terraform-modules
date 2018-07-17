resource "consul_node" "prometheus-service-consul_node" {
  name    = "${var.gc_project}-prometheus-endpoint"
  address = "${kubernetes_service.prometheus-kubernetes_service.load_balancer_ingress.0.ip}"
}

resource "consul_service" "prometheus-consul_service" {
  name = "${var.gc_project}-prometheus-server"
  node = "${consul_node.prometheus-service-consul_node}"
  port = "${var.prometheus-port}"
  tags = ["federated-server"]
}
