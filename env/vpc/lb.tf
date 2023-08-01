
module "gce-lb-http" {
  source  = "GoogleCloudPlatform/lb-http/google"
  version = "9.1.0" # specify the version based on your requirement

  project     = var.gcp_project
  name        = "lb-01"
  target_tags = ["instance-tag"] # ensure your instances have this tag

  backends = {
    "0" = {
      description                  = "instance group"
      protocol                     = "HTTP"
      port_name                    = "http"
      timeout_sec                  = 10
      connection_drain_timeout_sec = 10
      enable_cdn                   = false
      session_affinity             = "NONE"
      backend = [{
        group = google_compute_instance_group_manager.instance_group_manager.instance_group
      }]
    }
  }
}




# resource "google_compute_instance_group" "default" {
#   name        = "terraform-instance-group"
#   description = "Terraform test instance group"
#   zone        = "us-east1a"
#   network     = google_compute_network.vpc_network.self_link

#   instances = [
#     google_compute_instance.vm-01.id,
#     google_compute_instance.vm-02.id,
#   ]
# }

# resource "google_compute_http_health_check" "default" {
#   name               = "terraform-health-check"
#   request_path       = "/"
#   check_interval_sec = 5
#   timeout_sec        = 5
# }

# resource "google_compute_backend_service" "default" {
#   name        = "terraform-backend-service"
#   description = "Our first backend service"
#   port_name   = "http"
#   protocol    = "HTTP"

#   backend {
#     group = google_compute_instance_group.default.self_link
#   }

#   health_checks = [
#     google_compute_http_health_check.default.self_link
#   ]
# }

# resource "google_compute_url_map" "default" {
#   name            = "terraform-url-map"
#   default_service = google_compute_backend_service.default.self_link
# }

# # resource "google_compute_target_http_proxy" "default" {
# #   name    = "terraform-http-proxy"
# #   url_map = google_compute_url_map.default.self_link
# # }

# # resource "google_compute_global_forwarding_rule" "default" {
# #   name       = "terraform-forwarding-rule"
# #   target     = google_compute_target_http_proxy.default.self_link
# #   port_range = "80"
# #   ip_address = google_compute_global_address.default.address
# # }

# # resource "google_compute_global_address" "default" {
# #   name = "terraform-ip-address"
# # }
