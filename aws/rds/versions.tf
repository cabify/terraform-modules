terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "< 2"
    }
    mysql = {
      source  = "local/cabify/mysql"
      version = "= 1.9.1-p3"
    }
  }
}
