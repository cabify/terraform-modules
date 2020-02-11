# TEMPLATES #
data "template_file" "shutdown_script" {
  template = "${file("${path.module}/template/metadata_shutdown_script_template.sh")}"
}

data "template_file" "startup_script" {
  template = "${file("${path.module}/template/metadata_startup_script_mysqlha.sh")}"
}
