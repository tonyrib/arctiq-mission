
########################################### Providers ##################################################

terraform {
  required_version = ">= 0.12"
  backend "gcs" {
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}



########################################### GKE Cluster ################################################


module "gke" {
  source = "./Modules/GKE"
  project_id = var.project_id
  region = var.region
  google_compute_network_main_self_link = google_compute_network.main.self_link
  google_compute_subnetwork_private_self_link = google_compute_subnetwork.private.self_link
}

