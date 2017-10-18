# Terraform GCI and Route53 Private DNS 

Create a GCI instance with a private DNS record in route53

### Example usage

```
module "tf_gce_gci_route53_private" {
  source                         = "git@github.com:cabify/terraform-modules.git//tf_gce_gci_route53_private?ref=64fa248f311ebb0ceb07fe3cec127ec66706474c"
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
