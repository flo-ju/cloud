# Connexion fournisseur OpenStack
provider "openstack" {
  auth_url    = "https://<YOUR_AUTH_URL>"
  username    = "<YOUR_USERNAME>"
  password    = "<YOUR_PASSWORD>"
  tenant_name = "<YOUR_TENANT_NAME>"
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

# Création de 2 instances avec image ubuntu
resource "openstack_compute_instance_v2" "instance1" {
  name            = "instance1"
  flavor_name     = "m1.small"
  image_name      = "ubuntu"
  key_pair        = "<YOUR_KEYPAIR_NAME>"
  security_groups = ["default"]
  
  network {
    port = openstack_networking_network_v2.private_network.id
  }
}

resource "openstack_compute_instance_v2" "instance2" {
  name            = "instance2"
  flavor_name     = "m1.small"
  image_name      = "ubuntu"
  key_pair        = "<YOUR_KEYPAIR_NAME>"
  security_groups = ["default"]

  network {
    port = openstack_networking_network_v2.private_network.id
  }
}

# Création des volumes et ajout aux instances
resource "openstack_blockstorage_volume_v3" "volume1" {
  name        = "volume1"
  size        = 20
  description = "Volume 1 description"
}

resource "openstack_blockstorage_volume_v3" "volume2" {
  name        = "volume2"
  size        = 20
  description = "Volume 2 description"
}

resource "openstack_compute_volume_attach_v2" "va_1" {
  instance_id = openstack_compute_instance_v2.instance1.id
  volume_id   = openstack_blockstorage_volume_v3.volume1.id
}

resource "openstack_compute_volume_attach_v2" "va_2" {
  instance_id = openstack_compute_instance_v2.instance2.id
  volume_id   = openstack_blockstorage_volume_v3.volume2.id
}
