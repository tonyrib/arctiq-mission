
###################################### Variables #############################################


# define GCP project name
variable "project_id" {
  type        = string
  default = "cloudadv"
  description = "GCP project name"
}

# define GCP region
variable "region" {
  type        = string
  default = "us-central1"
  description = "GCP region"
}

variable "sql-instance" {
  type        = string
  default = "cloudadv-sql"
  description = "The storage class of the Google Storage Bucket to create"
}
