provider "google" {
  credentials = file("${path.module}/proyecto-21bae-firebase-adminsdk-fbsvc-60b174ac7c.json")
  project     = "proyecto-21bae"
  region      = "us-central1"
}

resource "google_project_service" "firebase" {
  project = "proyecto-21bae"
  service = "firebase.googleapis.com"
}

resource "google_project_service" "bigquery" {
  project = "proyecto-21bae"
  service = "bigquery.googleapis.com"
}
