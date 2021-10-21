# root/output.tf

output "load_balancer_dns_name" {
  value = module.loadbalancing.load_balancer_dns_name
}

output "instances" {
  value     = { for i in module.compute.instances : i.tags.Name => "${i.public_ip}:${module.compute.instance_port}" }
  sensitive = true
}