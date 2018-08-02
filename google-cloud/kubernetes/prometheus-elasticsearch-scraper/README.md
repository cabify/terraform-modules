# Description
Simple module to add monitoring to elasticsearch.
It can be configured to use any of these settings: [link](https://github.com/justwatchcom/elasticsearch_exporter#configuration)

# Usage

Without secrets management in place the current way to use this module create a tf setup:

```
variable "username" {}
variable "password" {}
variable "url" {}
variable "port" {}

module "cabify_elasticsearch_scraper" {
  source   = "../../../../../../../terraform-modules/google-cloud/kubernetes/prometheus-elasticsearch-scraper"
  username = "${var.username}"
  password = "${var.password}"
  url      = "${var.url}"
  port     = "${var.port}"

  project = "${data.terraform_remote_state.staging.gc_project}"
}
```

call the plan/apply stages with the variables as arguments:

```
terraform apply -var 'username=monitor' -var 'password=SUPERSECRET' -var 'url=192.168.0.1' -var 'port=9201'
```

## Args

### username
**Description:** Username to connect to elasticsearch
**Default:** admin

### password
**Description:** Password to connect to elasticsearch
**Default:** pass


### url
**Description:** url to connect to elasticsearch
**Default:** localhost


### port
**Description:** Port to connect to elasticsearch
**Default:** 9200

### project
**Description:** "Name of the gcp project"

