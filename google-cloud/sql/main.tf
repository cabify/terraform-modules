resource "google_sql_database_instance" "google_sql_database_instance-module-master" {
  name             = "${var.service_name}-master"
  database_version = "${var.database_engine_version}"

  region = var.instance_region

  settings {
    tier = var.instance_tier

    disk_autoresize = var.instance_disk_autoresize
    disk_type       = var.instance_disk_type

    availability_type = var.instance_failover_members > 0 ? "REGIONAL" : "ZONAL"
    replication_type  = "SYNCHRONOUS"

    backup_configuration {
      binary_log_enabled = "1"
      enabled            = "1"
    }

    database_flags {
      name  = "log_bin_trust_function_creators"
      value = "on"
    }

    database_flags {
      name  = "log_queries_not_using_indexes"
      value = "on"
    }

    database_flags {
      name  = "query_cache_size"
      value = "0"
    }

    maintenance_window {
      day          = var.instance_maintenance_day
      hour         = var.instance_maintenance_hour
      update_track = var.instance_maintenance_update_track
    }
  }
}

resource "google_sql_database_instance" "google_sql_database_instance-module-read-replica" {
  name                 = var.service_name}-read-replica-${count.index + 1
  database_version     = var.database_engine_version
  master_instance_name = google_sql_database_instance.google_sql_database_instance-module-master.name

  region = var.instance_region

  settings {
    tier = var.instance_tier_read_only_replica == "UNSET" ? var.instance_tier : var.instance_tier_read_only_replica

    disk_autoresize = var.instance_disk_autoresize
    disk_type       = var.instance_disk_type_read_only_replica == "UNSET" ? var.instance_disk_type : var.instance_disk_type_read_only_replica

    database_flags {
      name  = "log_bin_trust_function_creators"
      value = "on"
    }

    database_flags {
      name  = "log_queries_not_using_indexes"
      value = "on"
    }

    database_flags {
      name  = "query_cache_size"
      value = "0"
    }
  }

  count      = var.instance_read_only_replica_count
  depends_on = ["google_sql_database_instance.google_sql_database_instance-module-master"]
}

module "cabify_prometheus_mysql_scraper" {
  source                           = "git@github.com:cabify/terraform-modules.git//google-cloud/kubernetes/prometheus-mysql-scraper?ref=google-cloud_kubernetes-prometheus-mysql-scraper-v0.1.18"
  service_name                     = var.service_name
  user_name                        = var.user_name
  user_password                    = var.user_password
  instance_region                  = var.instance_region
  project                          = var.project
  namespace                        = var.namespace
  owner                            = var.owner
  tier                             = var.tier
  instance_read_only_replica_count = var.instance_read_only_replica_count
  instance_tier                    = var.instance_tier
  instance_tier_read_only_replica  = var.instance_tier_read_only_replica
}
