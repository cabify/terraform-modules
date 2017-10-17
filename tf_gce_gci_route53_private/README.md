# SoftLayer Hourly VM

Create a SoftLayer hourly VM with 2 DNS entries (public and private IPs).

### Example usage

```
module "softlayer_hourly_vm" {
  source              = "../../../modules/softlayer_hourly_vm"
  component           = "${var.component}"
  region              = "${data.terraform_remote_state.testing.region}"
  datacenter          = "${data.terraform_remote_state.testing.nomad_datacenter}"
  environment         = "${data.terraform_remote_state.testing.environment}"
  zone_id_int         = "${data.terraform_remote_state.testing.zone_id_int}"
  zone_id_ext         = "${data.terraform_remote_state.testing.zone_id_ext}"
  ssh_key_id          = "${data.terraform_remote_state.testing.softlayer_ssh_key_deploy_id}"
  post_install_script = "${data.terraform_remote_state.testing.post_install_script}"
  instance_count      = "${data.terraform_remote_state.testing.nomad_instances_count}"
}
```
