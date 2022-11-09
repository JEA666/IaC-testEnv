# output "ip" {
#   value = {
#     for addresses in libvirt_domanin.domain-ubuntu:
#     network_interface.addresses => addresses.ipv4_address
#   }
# }