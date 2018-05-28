To add a new database:

```
module "cabify_google_cloud_sql_mysql_test-database" {
  source = "../../../../../../terraform-modules/google-cloud/sql"
  service_name = "test"
  user_name = "test-user"
  user_password = "this-is-my-password"
  instance_region = "${data.terraform_remote_state.staging.gc_region}"
}
```
