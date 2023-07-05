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
