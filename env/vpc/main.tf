
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

