# Firewall rules
resource "google_compute_firewall" "mysql_cluster_replication" {
  name    = "mysql-cluster-${var.service_name}"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["33061"] # MySQL Group Replication port
  }

  target_tags = ["mysqlcluster-${var.service_name}"]

  # Bastions!
  source_ranges = [
    "34.90.26.15",
    "34.95.192.109",
  ]

  source_tags = ["mysqlcluster-${var.service_name}"]
}

resource "google_compute_firewall" "mysql_cluster" {
  name    = "mysql-cluster-replication-${var.service_name}"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["3306"] # MySQL Group Replication port
  }

  target_tags = ["mysqlcluster-${var.service_name}"]

  # Bastions!
  source_ranges = [
    "34.90.26.15",
    "34.95.192.109",
  ]

  source_tags = ["mysqlcluster-${var.service_name}"]
}

# MASTER INSTANCE #
resource "google_compute_address" "mysqlcluster_module_first" {
  name = "mysqlcluster-${var.service_name}-first"
}

resource "google_compute_instance" "mysqlcluster_module_first" {
  name         = "mysqlcluster-${var.service_name}-first"
  machine_type = "${var.first_instance_size}"

  # TODO: Improve zone definition to have each node in a different zone, at least for read replicas.
  zone                = "${var.zone_first}"
  deletion_protection = "${var.deletion_protection}"

  # TODO: Improve with persistent disk (SSD?) for data.
  boot_disk {
    initialize_params {
      size  = 100
      image = "${var.gcp_image}"
    }
  }

  network_interface {
    subnetwork = "${var.subnetwork}"

    access_config {
      nat_ip = "${google_compute_address.mysqlcluster_module_first.address}"
    }
  }

  # lets start w/o google account daemon bs from the start
  metadata = {
    host-group             = "mysqlcluster-${var.service_name}"
    block-project-ssh-keys = "TRUE"
    enable-oslogin         = "FALSE"
    shutdown-script        = "${data.template_file.shutdown_script.rendered}"
  }

  # not in metadata to _force_ recreation
  metadata_startup_script = "${data.template_file.startup_script.rendered}"

  tags = [
    "${var.service_name}",
    "mysqlcluster",
    "mysqlcluster-first",
    "mysqlcluster-${var.service_name}",
    "mysqlcluster-${var.service_name}-first",
  ]

  service_account {
    scopes = [
      # default scopes
      "https://www.googleapis.com/auth/logging.write",

      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",

      # for KMS encrypts/decrypts
      "https://www.googleapis.com/auth/cloudkms",

      # for reading/writing files from cloud storage
      "https://www.googleapis.com/auth/devstorage.read_write",
    ]
  }
}

# REPLICAS (instances number 2 and 3)
# Replica A
resource "google_compute_address" "mysqlcluster_module_second" {
  name = "mysqlcluster-${var.service_name}-second"
}

resource "google_compute_instance" "mysqlcluster_module_second" {
  name         = "mysqlcluster-${var.service_name}-second"
  machine_type = "${var.replica_instance_size}"

  # TODO: Improve zone definition to have each node in a different zone, at least for read replicas.
  #TODO
  zone = "${var.zone_second}"

  deletion_protection = "${var.deletion_protection}"

  # TODO: Improve with persistent disk (SSD?) for data.
  boot_disk {
    initialize_params {
      size  = 100
      image = "${var.gcp_image}"
    }
  }

  network_interface {
    subnetwork = "${var.subnetwork}"

    access_config {
      nat_ip = "${google_compute_address.mysqlcluster_module_second.address}"
    }
  }

  # lets start w/o google account daemon bs from the start
  metadata = {
    host-group             = "mysqlcluster-${var.service_name}"
    block-project-ssh-keys = "TRUE"
    enable-oslogin         = "FALSE"
    shutdown-script        = "${data.template_file.shutdown_script.rendered}"
  }

  # not in metadata to _force_ recreation
  metadata_startup_script = "${data.template_file.startup_script.rendered}"

  tags = [
    "${var.service_name}",
    "mysqlcluster",
    "mysqlcluster-second",
    "mysqlcluster-${var.service_name}",
    "mysqlcluster-${var.service_name}-second",
  ]

  service_account {
    scopes = [
      # default scopes
      "https://www.googleapis.com/auth/logging.write",

      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",

      # for KMS encrypts/decrypts
      "https://www.googleapis.com/auth/cloudkms",

      # for reading/writing files from cloud storage
      "https://www.googleapis.com/auth/devstorage.read_write",
    ]
  }

  depends_on = ["google_compute_instance.mysqlcluster_module_first"]
}

# Replica B
resource "google_compute_address" "mysqlcluster_module_third" {
  name = "mysqlcluster-${var.service_name}-third"
}

resource "google_compute_instance" "mysqlcluster_module_third" {
  name         = "mysqlcluster-${var.service_name}-third"
  machine_type = "${var.replica_instance_size}"

  # TODO: Improve zone definition to have each node in a different zone, at least for read replicas.
  #TODO
  zone = "${var.zone_third}"

  deletion_protection = "${var.deletion_protection}"

  # TODO: Improve with persistent disk (SSD?) for data.
  boot_disk {
    initialize_params {
      size  = 100
      image = "${var.gcp_image}"
    }
  }

  network_interface {
    subnetwork = "${var.subnetwork}"

    access_config {
      nat_ip = "${google_compute_address.mysqlcluster_module_third.address}"
    }
  }

  # lets start w/o google account daemon bs from the start
  metadata = {
    host-group             = "mysqlcluster-${var.service_name}"
    block-project-ssh-keys = "TRUE"
    enable-oslogin         = "FALSE"
    shutdown-script        = "${data.template_file.shutdown_script.rendered}"
  }

  # not in metadata to _force_ recreation
  metadata_startup_script = "${data.template_file.startup_script.rendered}"

  tags = [
    "${var.service_name}",
    "mysqlcluster",
    "mysqlcluster-third",
    "mysqlcluster-${var.service_name}",
    "mysqlcluster-${var.service_name}-third",
  ]

  service_account {
    scopes = [
      # default scopes
      "https://www.googleapis.com/auth/logging.write",

      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",

      # for KMS encrypts/decrypts
      "https://www.googleapis.com/auth/cloudkms",

      # for reading/writing files from cloud storage
      "https://www.googleapis.com/auth/devstorage.read_write",
    ]
  }

  depends_on = ["google_compute_instance.mysqlcluster_module_first"]
}
