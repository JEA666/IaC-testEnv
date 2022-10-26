# IaC-testEnv
Local test environment for KVM, Libvirt, Ansible, Terraform and Kubernetes

You need to generate a file called terraform.tfvars, and add your information.

    # Username and credentials
    ssh_username = "som user name" # for demo it is ubuntu
    ssh_private_key =  "path for your key"


Ther is a bug with libvirt, what works for me is to edit /etc/libvirt/qemu.conf

    security_driver = [ "none" ]


TODO

    Install latest Terraform Snap/Ansible ?
    Change folder ownership for terraform statfile
    IP routing, host to vm
    Define disk seize
