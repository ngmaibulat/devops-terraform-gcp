
variable "gcp_region" {
  default     = "us-central1"
  type        = string
  description = "GCP region"
}

variable "gcp_zone" {
  type        = string
  description = "Availability Zone inside GCP region"
}

variable "gcp_project" {
  type        = string
  description = "GCP project"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-central-1"
}
