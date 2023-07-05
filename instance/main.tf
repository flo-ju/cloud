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
output "network_id" {
  value = module.network.network_id
}

output "subnet_id" {
  value = module.network.subnet_id
}
# Création de 2 instances avec image ubuntu
resource "openstack_compute_instance_v2" "instance1" {
  name            = "instance1"
  flavor_name     = "m1.small"
  image_name      = "ubuntu"
  key_pair        = "<YOUR_KEYPAIR_NAME>"
  security_groups = ["default"]
  
  network {
    port = module.network.network_id
  }
}

resource "openstack_compute_instance_v2" "instance2" {
  name            = "instance2"
  flavor_name     = "m1.small"
  image_name      = "ubuntu"
  key_pair        = "<YOUR_KEYPAIR_NAME>"
  security_groups = ["default"]

  network {
    port = module.network.network_id
  }
}
