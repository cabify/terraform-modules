resource "kubernetes_namespace" "prometheus-scrapers" {
  metadata {
    annotations {
      type = "scrapers"
    }
    name = "prometheus-scrapers"
  }
}
