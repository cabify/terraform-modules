# Cert-Manager

## Introduction

[Official Cert-Manager documentation](https://docs.cert-manager.io/en/latest/index.html)

> cert-manager is a Kubernetes add-on to automate the management and issuance of TLS certificates from various issuing sources.

> It will ensure certificates are valid and up to date periodically, and attempt to renew certificates at an appropriate time before expiry.

> It is loosely based upon the work of kube-lego and has borrowed some wisdom from other similar projects e.g. kube-cert-manager.

![cert-manager](https://docs.cert-manager.io/en/latest/_images/high-level-overview.svg)

## Cert-Manager at cabify

We will create two ClusterIssuers one for staging and one for production. This
is because if you're trying to setup a new certificate for your service you
should be using the Staging Issuer so that Let's Encrypt validates the process
but doesn't provide a valid certificate. Then when the whole process is working
you can use the Production Issuer to get a valid certificate.

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
+ provider.kubernetes v1.1.0
+ provider.template v1.0.0
```

## What is happening under the hood

- Run the mandatory manifests for the cert-manager deployment in a Kubernetes
  cluster..
- Deploy Staging and Production ClusterIssuers that will be available
  clusterwide to request Certificates.

## Inputs Reference

### letsencrypt_email
**Description:** "It's an email that will authenticate us against Let's
  Encrypt. Generally it will be `systems+letsencrypt@cabify.com`. If someday
we'd like to have more granularity we should go with something like
`systems+letsencrypt+<service>@cabify.com`. Note that we may get some
notifications from let's encrypt in those emails"

### letsencrypt_prod_issuer_name
**Description:** "It's the name of the production issuer. This is necessary
  later when we want to create a certificate we need to specify which issuer
  is going to provide it."
**Default:** "letsencrypt-prod"

### letsencrypt_staging_issuer_name
**Description:** "Same as the above but for the staging issuer."
**Default:** "letsencrypt-staging"

## Outputs Reference

### letsencrypt_prod_issuer_name
**Description:** "It's the name of the production issuer. This is necessary
  later when we want to create a certificate we need to specify which issuer
  is going to provide it."

### letsencrypt_staging_issuer_name
**Description:** "Same as the above but for the staging issuer."

## Troubleshooting

If you have already applied this module and you wan't to know what is happening
with the cert-manager service use kubectl to checkout the logs.
```
kubectl logs -f -c cert-manager <pod-name>  -n cert-manager
```
