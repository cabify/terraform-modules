terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    k8s = {
      source = "banzaicloud/k8s"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}
