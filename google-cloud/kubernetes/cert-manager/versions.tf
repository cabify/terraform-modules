terraform {
  required_providers {
    k8s = {
      source = "banzaicloud/k8s"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}
