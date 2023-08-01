
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet-region1"
  region        = "us-east1"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.vpc_network.self_link
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "subnet-region2"
  region        = "us-west1"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc_network.self_link
}

# Cloud Router/Cloud NAT

resource "google_compute_router" "cloud_router" {
  name    = "cloud-router"
  network = google_compute_network.vpc_network.self_link
  region  = "us-west1"

  bgp {
    asn = 64514 # Private ASN for the Cloud Router to use
  }
}

resource "google_compute_router_nat" "cloud_nat" {
  name   = "cloud-nat"
  router = google_compute_router.cloud_router.name
  region = google_compute_router.cloud_router.region

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

