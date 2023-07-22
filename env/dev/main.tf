

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


resource "null_resource" "upload_website" {
  provisioner "local-exec" {
    command = "gsutil -m cp -r ../../data/* gs://${google_storage_bucket.bucket.name}"
  }

  triggers = {
    bucket = google_storage_bucket.bucket.id
  }
}

resource "google_storage_bucket_iam_binding" "public_read_access" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}
