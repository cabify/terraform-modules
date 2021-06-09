terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    mysql = {
      source  = "local/cabify/mysql"
      version = "= 1.9.1-p3"
    }
  }
}
