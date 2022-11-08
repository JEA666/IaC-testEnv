# IaC-testEnv

Local test environment for KVM, Libvirt, Ansible, Terraform and Rancher

## Step 1

Install ansible and KVM

    ./bootstrap

## Step 2

You need to generate a file called terraform.tfvars, and add your information.

    # Username and credentials
    ssh_username = "som user name" # for demo it is ubuntu
    ssh_private_key =  "path for your key"

## Step 3

Reboot PC

## Step 4

DOESN'T WORK WITH ROOTLESS DOCKER

Rancher command center!

    docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged --name=rancher rancher/rancher:latest
    docker logs rancher 2>&1 | grep "Bootstrap Password:"

## Step 5

Connect VM to rancher

    # Find VM ip
    virsh net-dhcp-leases default

ssh username and password is ubuntu

## Step 6

Run terraform

cd to terraform directory

    terraform init
    terraform plan
    terraform apply

To destroy your environment

    terraform destroy
