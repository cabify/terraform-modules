# Introduction

This module contains the resources and the steps to setup Oauth2 Proxy in a
Kubernetes Cluster.

Here is the [official documentation](https://github.com/bitly/oauth2_proxy#google-auth-provider)

Note: We only give support to Google Auth

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
- Nginx Ingress Controller deployed and ingress-nginx namespace already created.
  By default we assume we're going to use oauth2-proxy in conjuction with nginx.
  If this is not intended overwrite the namespace input.

Terraform Requirements
```
Terraform v0.11.7
+ provider.google v1.15.0
+ provider.k8s (unversioned)
+ provider.kubernetes v1.1.0
+ provider.template v1.0.0
```

Manual Requirements
- Create a Google API OAuth Client ID in the cabify-controlpanel project. This
  can't be done neither with gcloud or terraform, it has to be manually done.
  Follow [official oauth2_proxy documentation](https://github.com/bitly/oauth2_proxy#google-auth-provider)
- Once you create the credential, populate the variables `oauth2_proxy_client_id`
  and `oauth2_proxy_client_secret`.
- Then add the authorized redicrect URLs that you consider necessary. For
  example:
```
https://grafana.otters.xyz/oauth2/callback
https://grafana.otters.xyz/auth/login/google/authorize
http://grafana.otters.xyz/auth/login/google/authorize
```

## What is happening under the hood

- Create secrets for Oauth2 Proxy to store the Google Oauth Credential and a
  service account that can be potentially used in the future.
- Use a Deployment manifest to deploy Oauth2 Proxy in Kubernetes.

## Inputs Reference

### oauth2_proxy_client_id
**Description:** "Google API OAuth Client ID"

### oauth2_proxy_client_secret
**Description:** "Google API Oauth Client Secret"

### oauth2_proxy_cookie
**Description:** "The output of `python2.7 -c 'import os,base64; print base64.urlsafe_b64encode(os.urandom(16))'`"

### oauth2_proxy_deployment_namespace
**Description:** "The namespace where oauth2-proxy will be deployed"
**Default:** "ingress-nginx"

### oauth2_proxy_deployment_replicas
**Description:** "The number of replicas for the oauth2-proxy deployment"
**Default:** "1"

### oauth2_proxy_deployment_image
**Description:** "The docker image for the oauth2-proxy. Format should be like
`cabify/oauth2_proxy:latest`"

### oauth2_proxy_deployment_email_domain
**Description:** "The allowed email domain used for oauth. E.g. `cabify.com`"

## Outputs Reference

No Outputs.
