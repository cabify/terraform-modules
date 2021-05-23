terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.38.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
    mysql = {
      source  = "local/cabify/mysql"
      version = "= 1.9.1-p3"
    }
  }
}
