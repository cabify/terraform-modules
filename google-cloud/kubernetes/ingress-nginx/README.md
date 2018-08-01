# Introduction

This module contains the resources and the steps to setup the Nginx Ingress Controller
in a kubernetes cluster.

Here is the [official documentation](https://kubernetes.github.io/ingress-nginx/)

## Requirements

Kubernetes Requirements 
- The user applying this resources needs to be an admin in the kubernetes
  cluster. In the case of a CI make sure that this is automated. Here is an
example explaining how to do it.
```
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin \
  --user="$(gcloud config get-value account)"
```

Terraform Requirements
```
Terraform v0.11.7
+ provider.google v1.15.0
+ provider.k8s (unversioned)
+ provider.template v1.0.0
```

## What is happening under the hood 

- This module will create the namespace `ingress-nginx`
- Apply mandatory manifests to setup Nginx Ingress Controller inside a GKE
  cluster
- Create a static IP.
- Create a load balancer for the nginx ingress controller instance using the
  previous static IP.

## Inputs Reference

No Inputs

## Outputs Reference

### ingress_nginx_static_ip 
**Description:** "External IP address to access the nginx proxy"
