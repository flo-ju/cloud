terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "2023.1"
    }
  }
}
# Connexion au fournisseur OpenStack
provider "openstack" {
  auth_url    = "http://192.168.246.14:8080"
  username    = "admin"
  password    = "secret"
  tenant_name = "admin"
}

# Appel du module réseau
module "network" {
  source = "./network"
}

# Appel du module instances
module "instances" {
  source = "./instance"

}

# Appel du module volumes
module "volumes" {
  source = "./volume"

}

