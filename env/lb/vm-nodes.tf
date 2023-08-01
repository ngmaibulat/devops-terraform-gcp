

resource "google_compute_instance_template" "instance_template" {
  name_prefix  = "vm-template-"
  machine_type = "e2-micro"

  disk {
    source_image = data.google_compute_image.image.self_link
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet1.self_link

    access_config {
      // Ephemeral public IP
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "aibulat:${file("~/.ssh/id_rsa.pub")}"
  }

  metadata_startup_script = data.template_file.init[1].rendered
}

resource "google_compute_health_check" "default" {
  name               = "auto-healing-health-check"
  check_interval_sec = 15
  timeout_sec        = 5
  http_health_check {
    port = 80
  }
}


resource "google_compute_instance_group_manager" "instance_group_manager" {
  name               = "mig"
  base_instance_name = "vm"
  zone               = var.gcp_zone
  target_size        = 2


  version {
    name              = "dev"
    instance_template = google_compute_instance_template.instance_template.self_link
  }

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.default.self_link
    initial_delay_sec = 500 # Time before the health check is initially run on an instance.
  }

}


resource "google_compute_autoscaler" "default" {
  provider = google-beta
  name     = "autoscaler"
  zone     = var.gcp_zone
  target   = google_compute_instance_group_manager.instance_group_manager.id

  autoscaling_policy {
    max_replicas    = 4
    min_replicas    = 2
    cooldown_period = 400

    # metric {
    #   name                       = "pubsub.googleapis.com/subscription/num_undelivered_messages"
    #   filter                     = "resource.type = pubsub_subscription AND resource.label.subscription_id = our-subscription"
    #   single_instance_assignment = 65535
    # }
  }
}
