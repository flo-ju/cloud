output "network_id" {
  value = openstack_networking_network_v2.private_network.id
}

output "subnet_id" {
  value = openstack_networking_subnet_v2.private_subnet.id
}
