# Description
Simple module to add monitoring to redis.
It can be configured to use any of these settings: [link](https://github.com/oliver006/redis_exporter#flags)

# Usage

Without secrets management in place the current way to use this module create a tf setup:

```
variable "service" {}
variable "password" {}
variable "url" {}
variable "port" {}

module "cabify_redis_scraper" {
  source   = "git@github.com:cabify/terraform-modules.git//google-cloud/kubernetes/prometheus-redis-scraper?ref=google-cloud_kubernetes-prometheus-redis-scraper-v0.1.1"
  service  = "MyShinyService"
  password = "${var.password}"
  url      = "myredis-url-fqdn.com"
  port     = "15321"
  project  = "cabify-staging"
}
```

call the plan/apply stages with the variables as arguments:

```
terraform apply -var 'password=SUPERSECRET'
```

## Args

### service
**Description:** Service using this redis

### password
**Description:** Password to connect to redis
**Default:** pass


### url
**Description:** url to connect to redis
**Default:** localhost


### port
**Description:** Port to connect to redis
**Default:** 6379

### project
**Description:** "Name of the gcp project"

