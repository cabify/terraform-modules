resource "google_compute_instance" "vm" {
  name         = "${var.component}${count.index + 1}"
  machine_type = "${var.machine_type}"
  zone         = "${var.gce_zone}"
  count        = "${var.instance_count}"

  boot_disk {
    initialize_params {
      image = "${var.os_image}"
    }
  }

  scratch_disk {}

  network_interface {
    network = "default"

    access_config {}
  }

  metadata {
    host_group = "${var.host_group}"
    ssh-keys   = "${var.google_deployer_ssh_public_key}"
  }

  service_account {
    scopes = "${var.service_account_scopes}"
  }
}

resource "aws_route53_record" "dns-int" {
  zone_id = "${var.aws_route53_zone_id}"
  name    = "${var.component}${count.index + 1}.int.${var.aws_route53_zone_name}"
  type    = "A"
  ttl     = "60"
  count   = "${var.instance_count}"

  // matches up record N to instance N
  records = ["${element(google_compute_instance.vm.*.network_interface.0.address,count.index)}"]
}
