

resource "google_storage_bucket" "bucket" {
  name          = "ngm-storage-hello"
  location      = "US"
  storage_class = "STANDARD"

  force_destroy               = true
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}


# resource "null_resource" "upload_website" {

#   provisioner "local-exec" {
#     # command = "gsutil -m cp -r ../../data/* gs://${google_storage_bucket.bucket.name}"
#     # command = "bash scripts/deploy.sh ${google_storage_bucket.bucket.name}"
#     command = "ls -la"
#   }

#   triggers = {
#     bucket = google_storage_bucket.bucket.id
#   }
# }

resource "google_storage_bucket_iam_binding" "public_read_access" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}

data "google_compute_image" "image" {
  family  = "ubuntu-minimal-2204-lts"
  project = "ubuntu-os-cloud"
}

data "template_file" "init" {
  count = 3

  template = file("scripts/init.sh")

  vars = {
    index = count.index
  }
}

resource "google_compute_firewall" "default" {
  name    = "default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "default" {

  count        = 3
  name         = "srv-${count.index}"
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
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "aibulat:${var.SSH_KEY_PUB}"
  }

  # metadata_startup_script = "sudo apt update; sudo apt install -y nala; sudo nala install -y neofetch"
  # metadata_startup_script = file("scripts/init.sh")
  metadata_startup_script = data.template_file.init[count.index].rendered

  # provisioner "local-exec" {
  #   command = "ssh-keygen -R ${self.network_interface.0.access_config.0.nat_ip}"
  # }

}
