terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.1"
    }
  }
}
# Connexion au fournisseur OpenStack
provider "openstack" {
  auth_url    = "http://192.168.246.39/identity/"
  user_name    = "admin"
  password    = "secret"
  tenant_name = "admin"
}
module "network" {
  source = "./network"
  id_network = var.id_network
}

# Appel du module instances
module "instance" {
  source = "./instance"
  id_network = module.network.network_id
}

output "instance_id" {
  value = module.instance.instance_id
}
