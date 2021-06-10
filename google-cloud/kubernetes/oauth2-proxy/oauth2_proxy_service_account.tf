# Service Account for Oauth2 Proxy
# Checkout this [official
# documentation](https://github.com/bitly/oauth2_proxy#restrict-auth-to-specific-google-groups-on-your-domain-optional)
resource "google_service_account" "oauth2_proxy_service_account" {
  account_id   = "oauth2-proxy"
  display_name = "Oauth2 Proxy"
}

# This will be used as a secret
resource "google_service_account_key" "oauth2_proxy_service_account_key" {
  service_account_id = google_service_account.oauth2_proxy_service_account.name
}
