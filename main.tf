# Connexion au fournisseur OpenStack
provider "openstack" {
  auth_url    = "https://<YOUR_AUTH_URL>"
  username    = "<YOUR_USERNAME>"
  password    = "<YOUR_PASSWORD>"
  tenant_name = "<YOUR_TENANT_NAME>"
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

