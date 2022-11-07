# IaC-testEnv

Local test environment for KVM, Libvirt, Ansible, Terraform and Rancher

## Step 1

Install ansible

    ./bootstrap

## Step 2

Install KVM

    cd ansible
    ansible-playbook localHostProvisioning.yml --ask-become-pass

## Step 3 

Install Terraform

    snap install terraform --classic

## Step 4

You need to generate a file called terraform.tfvars, and add your information.

    # Username and credentials
    ssh_username = "som user name" # for demo it is ubuntu
    ssh_private_key =  "path for your key"

## Step 5

I had some problems with the network setup, my solution was to change the bridge for docker to KVM bridge.
Edit /etc/docker/daemon.json

    {
    "bridge": "virbr0",
    "iptables": false    
    }

Reboot PC

## Step 6

DOESN'T WORK WITH ROOTLESS DOCKER

Rancher command center!

    docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged --name=rancher rancher/rancher:latest
    docker logs rancher 2>&1 | grep "Bootstrap Password:"


## Step 7

Connect VM to rancher

    # Find vm ip
    virsh net-dhcp-leases default

ssh username and password is ubuntu

## Step 8

Run terraform 

cd to terraform directory

    terraform init
    terraform plan
    terraform apply

To destroy your environment

    terraform destroy

## Troubleshooting

There is a bug with libvirt, what worked for me was to edit /etc/libvirt/qemu.conf

    security_driver = [ "none" ]


## Future

TODO

    Install latest Terraform Snap/Ansible ?
    Change folder ownership for terraform statfile
