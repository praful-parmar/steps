#************output******************#

output "image-name" {
  value = docker_image.nodered__image.name
}
output "container-name" {
  value = docker_container.nodered_container[*].name
}
output "container-ip" {
  value       = [for i in docker_container.nodered_container : join(":", [i.ip_address], i.ports[*]["external"])]
  description = "ip address and ports"
  #  sensitive = true
}

