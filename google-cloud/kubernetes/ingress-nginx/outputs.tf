output "ingress_nginx_static_ip" {
  value = "${google_compute_address.ingress-nginx-static-ip.address}"
}
