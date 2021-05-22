terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "< 2"
    }
    mysql = {
      source = "terraform-providers/mysql"
    }
  }
}
