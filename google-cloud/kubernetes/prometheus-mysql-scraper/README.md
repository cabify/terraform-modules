# Description

# Usage

While this module can work on its own, in general, it is part of the sql module. As a result, monitoring is connected directly to the creation of the database, rather than a separate step.
```
module "cabify_prometheus_mysql_scraper" {
  source          = "git@github.com:cabify/terraform-modules.git//google-cloud/kubernetes/prometheus-mysql-scraper?ref=google-cloud_kubernetes-prometheus-mysql-scraper-v0.1.7"
  service_name    = "${var.service_name}"
  user_name       = "${var.user_name}"
  user_password   = "${var.user_password}"
  instance_region = "${var.instance_region}"
  project         = "${var.project}"
  namespace       = "${var.namespace}"
}
```
**NOTE:** We start a [cloudsql proxy](https://github.com/GoogleCloudPlatform/cloudsql-proxy) as part of the deployment and connect the scraper to it. This proxy needs its own service account so it has `connect` privileges to the db. It connects via a string such as: `cabify-staging:us-central1:corporate-master`. This translates to to following with the variables:

```
-instances=${var.project}:${var.instance_region}:${var.service_name}-master=tcp:0.0.0.0:3306
```


## Args

### user_name
**Description:** Username to connect to mysql

### user_password
**Description:** Password to connect to mysql

### service_name
**Description:** The service name we are using - this is part of the connection string

### instance_region
**Description:** The region we are running in - this is part of the connection string

### project
**Description:** "Name of the gcp project"

### namespace
**Description:** "Name of the kubernetes namespace"

