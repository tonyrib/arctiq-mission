
######################################## GKE Service ################################################

resource "kubernetes_manifest" "service_wordpress_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "wordpress"
      }
      "name" = "wordpress-service"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "port" = 80
          "targetPort" = 80
          "protocol" = "TCP"
        },
      ]
      "selector" = {
        "app" = "wordpress"
      }
      "type" = "LoadBalancer"
    }
  }
}
