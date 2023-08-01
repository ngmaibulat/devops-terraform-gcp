
resource "google_compute_instance" "bastion" {

  # count        = 2
  name         = "bastion"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      # image = "ubuntu/ubuntu-minimal-2204-lts"
      image = data.google_compute_image.image.self_link
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet1.self_link

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "aibulat:${file("~/.ssh/id_rsa.pub")}"
  }

  # metadata_startup_script = "sudo apt update; sudo apt install -y nala; sudo nala install -y neofetch"
  # metadata_startup_script = file("scripts/init.sh")
  metadata_startup_script = data.template_file.init[1].rendered

  provisioner "local-exec" {
    command = "ssh-keygen -R ${self.network_interface.0.access_config.0.nat_ip}"
  }

}
