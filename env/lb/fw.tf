
resource "google_compute_firewall" "allow_ssh_http_https" {
  name    = "allow-http-https"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "allow_icmp" {
  name    = "allow-icmp"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "icmp"
  }

  # source_ranges = ["0.0.0.0/0"]
  source_ranges = ["10.0.0.0/24", "10.0.1.0/24"]
}
