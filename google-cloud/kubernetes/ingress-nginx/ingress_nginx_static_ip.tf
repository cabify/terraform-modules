# Reserve static IP for the nginx controller.
# Note the IP can't be global but regional. Here are some useful resources.
# https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/static-ip
# https://serverfault.com/a/737779
resource "google_compute_address" "ingress_nginx_static_ip" {
  name         = "ingress-nginx-static-ip"
  address_type = "EXTERNAL"
  region       = var.region
}
