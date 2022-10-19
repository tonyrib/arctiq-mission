
###################################### Variables #############################################

variable "region" {
  type        = string
  description = "GCP region"
}

# define GCP project name
variable "project_id" {
  type        = string
  description = "GCP project name"
}

variable "google_compute_network_main_self_link" {
  type        = string
}

variable "google_compute_subnetwork_private_self_link" {
  type        = string
}
