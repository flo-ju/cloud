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

# Appel du module instances
module "instance" {
  source = "./instance"

}

output "instance_id" {
  value = module.instance.instance_id
}
