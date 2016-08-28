provider "digitalocean" {
    # Create a separate credentials.tf file that declares this variable.
	token 		= "${var.digitalocean_token}"
}

variable "os_image" 	{ default = "ubuntu-14-04-x64" }
variable "master_count" { default = 1 }
variable "worker_count" { default = 3 }

resource "digitalocean_droplet" "master" {
	count		= "${var.master_count}"

    image		= "${var.os_image}"
    name		= "swarm-master-${format("%02d", count.index + 1)}"
    region		= "nyc2"
    size		= "1gb"

    user_data	= "{\"role\":\"master\"}"

    ssh_keys	= ["${digitalocean_ssh_key.tintoy.fingerprint}"]
}

resource "digitalocean_droplet" "worker" {
	count		= "${var.worker_count}"

    image		= "${var.os_image}"
    name		= "swarm-worker-${format("%02d", count.index + 1)}"
    region		= "nyc2"
    size		= "1gb"

    user_data	= "{\"role\":\"worker\"}"

    ssh_keys	= ["${digitalocean_ssh_key.tintoy.fingerprint}"]
}

resource "digitalocean_ssh_key" "tintoy" {
	name		= "tintoy@skinner-box.local"
	public_key	= "${file("/Users/tintoy/.ssh/id_rsa.pub")}"
}
