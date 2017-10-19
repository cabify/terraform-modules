# Terraform Google VM with r53 private dns

Create a Google Compute Instance with a private DNS record in route53

### Example usage

In the following example we're creating 3 nomad agent instances.

```
module "nomad_agent" {
  source                         = "git@github.com:cabify/terraform-modules.git//google_vm_with_r53_private_dns?ref=1aac443ede51bc46a0a4b1d3493287e1537ade57"
  gce_zone                       = "${data.terraform_remote_state.testing.gce-zone}"
  component                      = "nomad"
  host_group                     = "nomad"
  instance_count                 = "3"
  aws_route53_zone_id            = "${data.terraform_remote_state.testing.aws_route53_zone_id}"
  aws_route53_zone_name          = "${data.terraform_remote_state.testing.aws_route53_zone_name}"
  machine_type                   = "n1-standard-1"
  google_deployer_ssh_public_key = "${data.terraform_remote_state.testing.google_deployer_ssh_public_key}"
}
```
