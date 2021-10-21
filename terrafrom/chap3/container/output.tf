#************output******************#

# output "image-name" {
#   value = docker_image.nodered__image.name
# }
# output "container_name" {
#   value = docker_container.nodered_container.name
# }
# output "container_ip" {
#   value       = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
#   description = "ip address and ports"
#   #  sensitive = true
# }

output "application_access" {
  value = { for x in docker_container.app_container[*] : x.name => join("-", [x.ip_address], x.ports[*]["external"]) }
}