output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "google_compute_network_main_self_link" {
  value       = google_compute_network.main.self_link
}

output "google_compute_subnetwork_private_self_link" {
  value       = google_compute_subnetwork.private.self_link
}