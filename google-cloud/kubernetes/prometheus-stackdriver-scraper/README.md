# Descriptoin
A module to create scrapers for any stackdriver endpoint.
This module creates its own readonly service account to access the stackdriver api.
By passing in arguments from [gcp metrics](https://cloud.google.com/monitoring/api/metrics_gcp) or [agent_metrics](https://cloud.google.com/monitoring/api/metrics_agent) the module can scrape many different use-cases.

# Usage

This is a sample to monitor some of the cloudsql endpoints from stackdriver:
```
module "cabify_google_cloud_sql_stackdriver_scraper" {
  source  = "git@github.com:cabify/terraform-modules.git//google-cloud/kubernetes/prometheus-stackdriver-scraper?ref=google-cloud_kubernetes-prometheus-stackdriver-scraper-v0.1.7"
  service = "cloudsql"

  args = ["--google.project-id",
    "cabify-staging",
    "--monitoring.metrics-type-prefixes",
    "\"cloudsql.googleapis.com/database/disk,cloudsql.googleapis.com/database/cpu,cloudsql.googleapis.com/database/memory,cloudsql.googleapis.com/database/state,cloudsql.googleapis.com/database/up,cloudsql.googleapis.com/database/auto_failover_request_count,cloudsql.googleapis.com/database/available_for_failover\"",
  ]

  project = "${data.terraform_remote_state.staging.gc_project}"
}
```

**NOTE:** The metrics are have to be quoted - as a result the quotes are escaped.

## Args

### service
**Description:** "Name of the service - will be used for instance names"

### args
**Description:** "List of args passed to the docker container - [Example](https://github.com/frodenas/stackdriver_exporter#example)"

### project
**Description:** "Name of the gcp project"
