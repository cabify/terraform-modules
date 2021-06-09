terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    k8s = {
      source = "banzaicloud/k8s"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.13"
}
