terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker" //provide source
      version = "~> 2.12"            // allow version 2.12 to 2.max 
    }
  }
}

provider "docker" {}

resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && chown 1000 noderedvol/"
  }
}


//download images
resource "docker_image" "nodered__image" { //first is provide name and second is alias for call it
  name = var.image[terraform.workspace]    //name of the image ( docker hub image )
}

resource "random_string" "randomstring" {
  count   = local.container_count
  length  = 4
  special = false
  upper   = false
  number  = false
}





//deploy image
resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered", terraform.workspace, random_string.randomstring[count.index].result])
  image = docker_image.nodered__image.latest
  ports {
    internal = var.intport
    external = var.extport[terraform.workspace][count.index]
  }
  volumes {
    container_path = "/data"
    host_path      = "${path.cwd}/noderedvol"
  }

}