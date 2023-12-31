resource "google_compute_instance_template" "instance_template" {
  name_prefix  = "instance-template-"
  machine_type = "e2-micro"

  disk {
    source_image = data.google_compute_image.image.self_link
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  name               = "mig"
  base_instance_name = "vm"
  zone               = "us-east1-b"
  target_size        = 2


  version {
    name              = "dev"
    instance_template = google_compute_instance_template.instance_template.self_link
  }



  named_port {
    name = "http"
    port = 80
  }
}
