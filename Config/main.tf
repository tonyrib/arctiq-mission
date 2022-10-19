
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

# Configure kubernetes provider with Oauth2 access token.
data "google_client_config" "default" {}

data "google_container_cluster" "primary" {
  name     = var.kubernetes_cluster_name
  location = var.region
}

provider "kubernetes" {
  host = "https://${data.google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}


########################################### Secrets ###################################################


resource "kubernetes_manifest" "sql-credentials" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Secret"
    "metadata" = {
      "name"      = "sql-credentials"
      "namespace" = "default"
    }
    "data" = {
      "username" = "c3FsdXNlcg=="
      "password" = "c3FscGFzc3dvcmQ="
    }
  }
}

resource "kubernetes_secret" "google-credentials" {

      metadata {
        name      = "google-credentials"
        namespace = "default"
        labels = {
          "sensitive" = "true"
        }
      }
      data = {
        "key.json" = file("${path.cwd}/credentials.json")
      }
    }



###################################### Workloads & Services #################################################


module "deployment_wordpress" {
  source = "./Modules/Deployments"
  depends_on = [kubernetes_manifest.sql-credentials]
}

module "service_wordpress" {
  source = "./Modules/Services"
  depends_on = [module.deployment_wordpress]
}


