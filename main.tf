variable "do_token"                 { }

variable "droplet_name"             { }
variable "droplet_region"           { }
variable "droplet_size"             { }

variable "public_key"               { }
variable "private_key"              { }

variable "client_id"                { }
variable "client_secret"            { }

# Configure the Digital Ocean Provider
provider "digitalocean" {
    token                   = "${var.do_token}"
}

resource "template_file" "drone_setup" {
  template = "${path.module}/scripts/setup_drone.sh.tpl"

  vars {
    client_id               = "${var.client_id}"
    client_secret           = "${var.client_secret}"
  }
}

# Create Droplet w/ Docker for Drone.io
resource "digitalocean_droplet" "ci" {
    image                   = "docker"
    name                    = "${var.droplet_name}"
    region                  = "${var.droplet_region}"
    size                    = "${var.droplet_size}mb"

    ipv6                    = true
    private_networking      = true

    ssh_keys                = [
        "${digitalocean_ssh_key.ci.fingerprint}"
    ]

    connection {
        user                = "root"
        type                = "ssh"
        key_file            = "${var.private_key}"
        timeout             = "2m"
    }

    provisioner "remote-exec" {
        inline = ["${template_file.drone_setup.rendered}"]
    }
}

resource "digitalocean_floating_ip" "ci" {
    droplet_id              = "${digitalocean_droplet.ci.id}"
    region                  = "${digitalocean_droplet.ci.region}"
}

resource "digitalocean_ssh_key" "ci" {
    name                    = "ci-public-ssh-key"
    public_key              = "${var.public_key}"
}
