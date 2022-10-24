# hmm what is a good comment for a file of variables ?

variable "backend_path" {
    description = "value"
    default = "/home/jea/tmp/tfstate/terraform.tfstate"
  
}

variable "libvirt_disk_path" {
  description = "path for libvirt pool"
  default     = "/var/lib/libvirt/images/tf-pool01"
}

variable "ubuntu_22_04" {
  description = "Ubuntu 22.04 Cloud-init image"
  default     = "https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img"
  # sertified cloud? https://cloud-images.ubuntu.com/jammy/20221018/jammy-server-cloudimg-amd64-disk-kvm.img
  # standard img https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img
}

# variable "vm_hostname" {
#   description = "vm hostname, known as domain in kvm"
#   default     = "ranode"
# }

variable "ssh_username" {
  description = "the ssh user to use"
}

variable "ssh_private_key" {
  description = "the private key to use"
}