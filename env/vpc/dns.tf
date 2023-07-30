### Private DNS

resource "google_dns_managed_zone" "private_zone" {
  name        = "private-zone"
  dns_name    = "corp.internal." // Don't forget the trailing dot
  description = "Private DNS zone"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc_network.self_link
    }
  }
}

resource "google_dns_record_set" "www" {
  name         = "www.corp.internal."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.private_zone.name
  rrdatas      = ["10.0.0.2"]
}

resource "google_dns_managed_zone" "public_zone" {
  name        = "public-zone"
  dns_name    = "terraform.academy." # replace this with your domain name
  description = "Public DNS zone"
}

resource "google_dns_record_set" "record_set" {
  name         = "lab.terraform.academy." # replace this with your desired record
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.public_zone.name
  rrdatas      = ["8.8.8.8"] # replace this with your desired IP address
}
