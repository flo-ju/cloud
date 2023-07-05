terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.1"
    }
  }
}

# Appel du module instances
module "instance" {
  source = "../instance"
}
output "instance_id" {
  value = module.instance.instance_id
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
