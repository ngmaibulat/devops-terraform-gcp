

# output "ip" {
#   value       = google_compute_instance.default[*].network_interface[0].access_config[0].nat_ip
#   description = "External IP"
# }


output "ip-1" {
  value       = google_compute_instance.vm-01.network_interface[0].access_config[0].nat_ip
  description = "IP1"
}

# output "ip-2" {
#   value       = google_compute_instance.vm-02.network_interface[0].access_config[0].nat_ip
#   description = "IP2"
# }
