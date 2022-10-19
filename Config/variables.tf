variable "project_id" {
  default = "cloudadv"
  type        = string
}

variable "region" {
  type        = string
  default = "us-central1"
  description = "GCP region"
}

variable "kubernetes_cluster_name" {
  description = "Name of the gke cluster"
  default = "cloudadv-gke"
  type        = string
}

variable "sql-instance" {
  type        = string
  default = "cloudadv-sql"
  description = "The storage class of the Google Storage Bucket to create"
}

