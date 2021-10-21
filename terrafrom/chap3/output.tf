#************output******************#

# output "image" {
#   value = docker_image.nodered__image.name
# }
# output "container_name" {
#   value = module.container[*].container_name
# }
# output "container_ip" {
#   value       = flatten(module.container[*].container_ip)
#   description = "ip address and ports"
#   #  sensitive = true
# }

output "application_access" {
  value       = module.container[*]
  description = "application access port and ip addresss"
}