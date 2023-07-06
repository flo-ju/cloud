terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.1"
    }
  }
}

# Appel du module réseau
module "network" {
  source = "../network"
}
# Création de 2 instances avec image ubuntu
resource "openstack_compute_instance_v2" "instance1" {
  name            = "instance1"
  flavor_name     = "m1.tiny"
  image_name      = "ubuntu"
  security_groups = ["default"]
  
  network {
    uuid = var.network_id
    subnet = var.subnet_id
  }
}

resource "openstack_compute_instance_v2" "instance2" {
  name            = "instance2"
  flavor_name     = "m1.tiny"
  image_name      = "ubuntu"
  security_groups = ["default"]

  network {
  	uuid = var.network_id
	subnet = var.subnet_id
  }
}
