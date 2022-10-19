
######################################## GKE Workload ################################################


resource "kubernetes_manifest" "deployment_wordpress" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "default"
      "labels" = {
        "app" = "wordpress"
      }
      "name" = "wordpress"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "wordpress"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "wordpress"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "WORDPRESS_DB_HOST"
                  "value" = "127.0.0.1:3306"
                },
                {
                  "name" = "WORDPRESS_DB_USER"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "username"
                      "name" = "sql-credentials"
                    }
                  }
                },
                {
                  "name" = "WORDPRESS_DB_PASSWORD"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "password"
                      "name" = "sql-credentials"
                    }
                  }
                },
              ]
              "image" = "gcr.io/cloud-marketplace/google/wordpress:5.9"
              "name" = "web"
              "ports" = [
                {
                  "containerPort" = 80
                },
              ]
            },
            {
              "command" = [
                "/cloud_sql_proxy",
                "-instances=cloudadv:us-central1:cloudadv-sql=tcp:3306",
                "-credential_file=/secrets/cloudsql/key.json",
              ]
              "image" = "gcr.io/cloudsql-docker/gce-proxy:1.11"
              "name" = "cloudsql-proxy"
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "runAsUser" = 2
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/secrets/cloudsql"
                  "name" = "cloudsql-instance-credentials"
                  "readOnly" = true
                },
              ]
            },
          ]
          "volumes" = [
            {
              "name" = "cloudsql-instance-credentials"
              "secret" = {
                "secretName" = "google-credentials"
              }
            },
          ]
        }
      }
    }
  }
}
