# GCP SQL - MySQL module

## Usage
To add a new database at minimum:

```
module "cabify_google_cloud_sql_mysql_test-database
  source = "../../../../../../terraform-modules/google-cloud/sql"
  service_name = "test"
  user_name = "test-user"
  user_password = "this-is-my-password"
  instance_tier = "db-n1-standard-2"
  instance_disk_type = "PD_HDD"
  instance_region = "${data.terraform_remote_state.staging.gc_region"

```


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
  **Default:** "db-n1-standard-2"

