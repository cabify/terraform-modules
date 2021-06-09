terraform {
  required_providers {
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
}
