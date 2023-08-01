

module "gce-lb-http" {
  source  = "GoogleCloudPlatform/lb-http/google"
  version = "9.1.0" # specify the version based on your requirement

  project     = var.gcp_project
  name        = "lb"
  target_tags = ["instance-tag"] # ensure your instances have this tag

  load_balancing_scheme = "EXTERNAL_MANAGED"

  backends = {
    "0" = {
      description                  = "instance group"
      protocol                     = "HTTP"
      port_name                    = "http"
      timeout_sec                  = 10
      connection_drain_timeout_sec = 10
      enable_cdn                   = false
      session_affinity             = "NONE"

      # backend = [{
      #   group = google_compute_instance_group_manager.instance_group_manager.self_link
      # }]

      health_check = {
        check_interval_sec  = null
        timeout_sec         = null
        healthy_threshold   = null
        unhealthy_threshold = null
        request_path        = "/"
        port                = 80
        host                = null
        logging             = null
      }

      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [
        {
          group           = google_compute_instance_group_manager.instance_group_manager.instance_group
          balancing_mode  = "UTILIZATION"
          capacity_scaler = 1.0
          max_utilization = 0.8
          description     = "backend group"
        }
      ]

      # groups = [
      # {
      #   # Each node pool instance group should be added to the backend.
      #   group                        = google_compute_instance_group_manager.instance_group_manager.self_link
      #   balancing_mode               = null
      #   capacity_scaler              = null
      #   description                  = null
      #   max_connections              = null
      #   max_connections_per_instance = null
      #   max_connections_per_endpoint = null
      #   max_rate                     = null
      #   max_rate_per_instance        = null
      #   max_rate_per_endpoint        = null
      #   max_utilization              = null
      # },
      # ]


      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}
