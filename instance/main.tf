terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.1"
    }
  }
}

# Création de 2 instances avec image ubuntu
resource "openstack_compute_instance_v2" "instance1" {
  name            = "instance1"
  flavor_name     = "m1.small"
  image_name      = "ubuntu"
  security_groups = ["default"]
  
  network {
    uuid = var.network_id
  }
}

resource "openstack_compute_instance_v2" "instance2" {
  name            = "instance2"
  flavor_name     = "m1.small"
  image_name      = "ubuntu"
  security_groups = ["default"]

  network {
  	uuid = var.network_id
  }
}
