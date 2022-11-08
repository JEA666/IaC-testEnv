# Create disk pool and disk - Global
resource "libvirt_pool" "tf_ubuntu" {
  name = "tf_ubuntu"
  type = "dir"
  path = var.libvirt_disk_path
}

resource "libvirt_volume" "os_image_ubuntu" {
  count  = var.domain_count
  name   = "os_image_ubuntu-${count.index}"
#  name   = "os_image_ubuntu"
  pool   = libvirt_pool.tf_ubuntu.name
  source = var.ubuntu_22_04
}

resource "libvirt_volume" "disk_ubuntu_resized" {
  count          = var.domain_count 
  name           = "disk-${count.index}"
#  name           = "disk"
  base_volume_id = libvirt_volume.os_image_ubuntu[count.index].id
#  base_volume_id = libvirt_volume.os_image_ubuntu.id 
  pool           = libvirt_pool.tf_ubuntu.name
  size           = 8361393152
}

# Rancher Cattle config
resource "libvirt_cloudinit_disk" "ubuntu_" {
  count          = var.domain_count
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
  count  = var.domain_count
  name   = "${var.domain_name}-${count.index}"
  memory = "4096"
  vcpu   = 2

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
    volume_id = libvirt_volume.disk_ubuntu_resized[count.index].id
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
    