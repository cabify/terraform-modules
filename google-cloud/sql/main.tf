resource "google_sql_database_instance" "google_sql_database_instance-module-master" {
  name             = "${var.service_name}-master"
  database_version = "${var.database_engine_version}"

  region = "${var.instance_region}"

  settings {
    tier = "${var.instance_tier}"

    disk_autoresize = "${var.instance_disk_autoresize}"
    disk_size       = "${var.instance_disk_size}"
    disk_type       = "${var.instance_disk_type}"

    backup_configuration {
      binary_log_enabled = "${var.instance_failover_members > 0 ? 1 : 0}"
      enabled            = "${var.instance_failover_members > 0 ? 1 : 0}"
    }

    maintenance_window {
      day          = "${var.instance_maintenance_day}"
      hour         = "${var.instance_maintenance_hour}"
      update_track = "${var.instance_maintenance_update_track}"
    }
  }
}

resource "google_sql_database_instance" "google_sql_database_instance-module-failover" {
  name                 = "${var.service_name}-failover-${count.index + 1}"
  database_version     = "${var.database_engine_version}"
  master_instance_name = "${google_sql_database_instance.google_sql_database_instance-module-master.name}"

  region = "${var.instance_region}"

  settings {
    tier = "${var.instance_tier}"
  }

  replica_configuration {
    failover_target = true
  }

  count      = "${var.instance_failover_members}"
  depends_on = ["google_sql_database_instance.google_sql_database_instance-module-master"]
}

resource "google_sql_database_instance" "google_sql_database_instance-module-read-replica" {
  name                 = "${var.service_name}-read-replica-${count.index + 1}"
  database_version     = "${var.database_engine_version}"
  master_instance_name = "${google_sql_database_instance.google_sql_database_instance-module-master.name}"

  region = "${var.instance_region}"

  settings {
    tier = "${var.instance_tier}"
  }

  count      = "${var.instance_read_only_replica_count}"
  depends_on = ["google_sql_database_instance.google_sql_database_instance-module-master"]
}