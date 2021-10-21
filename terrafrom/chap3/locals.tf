locals {
  deployment = {
    nodered = {
      container_count = length(var.extport["nodered"][terraform.workspace])
      image           = var.image["nodered_image"][terraform.workspace]
      int             = 1880
      ext             = var.extport["nodered"][terraform.workspace]
      #path            = "/data"
      volumes = [{ container_path_each = "/data" }]
    }
    influxdb = {
      container_count = length(var.extport["influxdb"][terraform.workspace])
      image           = var.image["influxdb_image"][terraform.workspace]
      int             = 8086
      ext             = var.extport["influxdb"][terraform.workspace]
      # path            = "/var/lib/influxdb"
      volumes = [{ container_path_each = "/var/lib/influxdb" },
      { container_path_each = "/etc" }]
    }
    grafana = {
      container_count = length(var.extport["grafana"][terraform.workspace])
      image           = var.image["grafana_image"][terraform.workspace]
      int             = 3000
      ext             = var.extport["grafana"][terraform.workspace]
      volumes = [{ container_path_each = "/opt/bitnami/grafana" },
      { container_path_each = "/etc/grafana" }]
    }
  }
}