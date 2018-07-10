# GCP SQL - MySQL module

## Usage
To add a new database at minimum:

```
module "cabify_google_cloud_sql_mysql_test-database" {
  source             = "git@github.com:cabify/terraform-modules.git//google-cloud/sql?ref=google-cloud_sql-v0.1.1"
  service_name = "test"
  user_name = "test-user"
  user_password = "this-is-my-password"
  instance_tier = "db-n1-standard-2"
  instance_disk_type = "PD_HDD"
  instance_region = "${data.terraform_remote_state.staging.gc_region}"
  project              = "${data.terraform_remote_state.staging.gc_project}"
  service_account_file = "${var.service_account_folder}/${data.terraform_remote_state.staging.gc_project}.json"
}
```

where `?ref=google-cloud_sql-v0.1.1` corresponds to a TAG in this repository.

## Prerequisites for monitoring

### Kubernetes

Kubernetes has to work in order to use the [provisioner](https://www.terraform.io/docs/providers/kubernetes/guides/getting-started.html).
The easiest way to set this up is via gcloud:

```
gcloud container clusters get-credentials <GOOGLE-CLOUD-PROJECT> --zone <REGION>
```

This will create the file `~/.kube/config` with the minimal settings.


### Service account Environment variable

Since this module should be CI compliant, the service account for the sql proxy is passed in via environment variable:

```
$ export TF_VAR_service_account_folder=/path/to/my/serviceaccounts/.gcp
```

These are **NOT** your service account, but the monitoring service account's json credentials.
We expect to find a file per google cloud project in that folder, iE

```
/path/to/my/serviceaccounts/.gcp/cabify-staging.json
```

In the future CI wrappers will take care of this heavy lifting for us.


## Argument references
### service_name
**Description:** "Name of the service - will be used for instance names"


### database_charset
**Description:** "Database character set - default should be correct"
**Default:** "utf8"


### database_engine_version
**Description:** "Type of database to use - We currently use 5.7 everywhere"
**Default:** "MYSQL_5_7"


### database_name
**Description:** "Name of the database - if not set, service_name is used"
**Default:** "UNSET"


### user_host
**Description:** "Hosts the user is allowed to connect from"
**Default:** "%"


### user_name
**Description:** "Username for the db (16 char max length)"


### user_password
**Description:** "Clear text password for db user"


### instance_maintenance_day
**Description:** "Day of the week to perform maintenance (mon-sun = 1-7)"
**Default:** 1


### instance_maintenance_hour
**Description:** "Hour of the day to perform maintenance (0-23)"
**Default:** 8


### instance_maintenance_update_track
**Description:** "Receive updates earlier (canary) or later (stable)"
**Default:** "canary"


### instance_disk_autoresize
**Description:** "Will the disk autosize to the usage"
**Default:** true


### instance_disk_size
**Description:** "Size in Gb of the disk"
**Default:** 10


### instance_disk_type
**Description:** "Disk backend to use - PD_HDD or PD_SSD"


### instance_failover_members
**Description:** "Number of failover instances to start"
**Default:** 1


### instance_read_only_replica_count
**Description:** "Number of read only replicas to create"
**Default:** 0


### instance_region
**Description:** "Where to start the instances"


### instance_tier
**Description:** "Type of instance to use - see https://cloud.google.com/sql/pricing#2nd-gen-instance-pricing"

### project
**Description:** "Name of the gcp project - this is automatically filled"

### service_account_file
**Description:** "Service account to use for the monitoring containers"
