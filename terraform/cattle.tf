# Create disk pool and disk - Global
resource "libvirt_pool" "tf_ubuntu" {
  name = "tf_ubuntu"
  type = "dir"
  path = var.libvirt_disk_path
}

# Base OS image to use to create a cluster of different nodes
resource "libvirt_volume" "ubuntu-22_04" {
  name   = "ubuntu-22_04"
  source = var.ubuntu_22_04
}

# volume to attach to the "nodes" domain as main disk
resource "libvirt_volume" "nodes" {
  name           = "nodes_${count.index}.qcow2"
  base_volume_id = libvirt_volume.ubuntu-22_04.id
  pool           = libvirt_pool.tf_ubuntu.name
  size           = 8361393152
  count          = var.node_count
}

# Rancher Cattle config
resource "libvirt_cloudinit_disk" "ubuntu_" {
  count          = var.node_count
  name           = "ubuntu_${count.index}.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.tf_ubuntu.name
}
data "template_file" "user_data" {
  template = file("${path.module}/config/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/config/network.cfg")
}

# Deploy Rancher cattles
resource "libvirt_domain" "domain-ubuntu" {
  count  = var.node_count
  name   = "${var.node_name}-${count.index}"
  memory = "8192"
  vcpu   = 4

  cloudinit = libvirt_cloudinit_disk.ubuntu_[count.index].id

  network_interface {
    network_name = "default"
  }

# Needed for cloud init images
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.nodes_[count.index].qcow2.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
# End of cattle config

terraform {
    required_version = ">= 1.3.3"
}
    