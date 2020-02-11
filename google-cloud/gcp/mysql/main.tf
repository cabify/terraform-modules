# MASTER INSTANCE #
resource "google_compute_address" "mysqlcluster-module_first" {
  name = "mysqlcluster-${var.service_name}-first"
}

resource "google_compute_instance" "mysqlcluster-module_first" {
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
      nat_ip = "${google_compute_address.mysqlcluster-module_first.address}"
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
resource "google_compute_address" "mysqlcluster-module_second" {
  name = "mysqlcluster-${var.service_name}-second"
}

resource "google_compute_instance" "mysqlcluster-module_second" {
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
      nat_ip = "${google_compute_address.mysqlcluster-module_second.address}"
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
}

# Replica B
resource "google_compute_address" "mysqlcluster-module_third" {
  name = "mysqlcluster-${var.service_name}-third"
}

resource "google_compute_instance" "mysqlcluster-module_third" {
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
      nat_ip = "${google_compute_address.mysqlcluster-module_third.address}"
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
}
