# IaC-testEnv

Local test environment for KVM, Libvirt, Ansible, Terraform and Rancher

## Step 1

You need to generate a file called terraform.tfvars, and add your information.

    # Username and credentials
    ssh_username = "som user name" # for demo it is ubuntu
    ssh_private_key =  "path for your key"

## Step 2

I had some problems with the network setup, my solution was to change the bridge for docker to KVM bridge.
Edit /etc/docker/daemon.json

    {
    "bridge": "virbr0",
    "iptables": false    
    }

## Step 3

Rancher command center!

    docker run -d --restart=unless-stopped   -p 80:80 -p 443:443   --privileged   rancher/rancher:latest

    # Find container id
    docker ps

    # Get password
    docker logs 'container id' 2>&1 | grep "Bootstrap Password:"

## Step 4

Connect VM to rancher

    # Find vm ip
    virsh net-dhcp-leases default

    # ssh username and password is ubuntu

## Troubleshooting

There is a bug with libvirt, what worked for me was to edit /etc/libvirt/qemu.conf

    security_driver = [ "none" ]

## Future

TODO

    Install latest Terraform Snap/Ansible ?
    Change folder ownership for terraform statfile
