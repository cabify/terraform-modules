# This secret contains Google API OAuth credentials for Oauth2 Proxy.
resource "kubernetes_secret" "oauth2_proxy_api_oauth_credentials" {
  metadata {
    name      = "oauth2-proxy-api-oauth-credentials"
    namespace = "${var.oauth2_proxy_deployment_namespace}"
  }

  data {
    client_id     = "${var.oauth2_proxy_client_id}"
    client_secret = "${var.oauth2_proxy_client_secret}"
    cookie        = "${var.oauth2_proxy_cookie}"
  }
}
