output "details" {
  value = <<DETAILS
Droplet Public IP:
  ${digitalocean_floating_ip.ci.ip_address}

DETAILS
}