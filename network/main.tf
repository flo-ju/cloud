terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.1"
    }
  }
}
# Création réseau sous réseau routeur
resource "openstack_networking_network_v2" "private_network" {
  name        = "private_network"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name       = "private_subnet"
  network_id = openstack_networking_network_v2.private_network.id
  cidr       = "192.168.0.0/24"
  ip_version = 4
}

resource "openstack_networking_router_v2" "router" {
  name        = "router"
  admin_state_up = true
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id      = openstack_networking_router_v2.router.id
  subnet_id      = openstack_networking_subnet_v2.private_subnet.id
}
