################################################################################
## Instances Names
################################################################################
output "mysqlcluster_first_name" {
  value = google_compute_instance.mysqlcluster_module_first.name
}

# output "mysqlcluster_second_name" {
#   value = google_compute_instance.mysqlcluster_module_second.name
# }
#
# output "mysqlcluster_third_name" {
#   value = google_compute_instance.mysqlcluster_module_third.name
# }
