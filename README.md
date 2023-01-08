# IaC-testEnv

## Base environment.
Local test environment with KVM, Libvirt, Ansible, and Terraform.  
## Step 1

Install Ansible and KVM

    ./bootstrap.sh

## Step 2

You need to generate a file called terraform.tfvars, and add your information.

    # Username and credentials
    ssh_username = "som user name" # for demo it is ubuntu
    ssh_private_key =  "path for your key"

You also need to edit variables.tf for variables from your environment.

## Step 3

Reboot PC

## Step 4

Run terraform

cd to terraform directory

    terraform init
    terraform plan
    terraform apply

[Test environment with Rancher](./docs/Rancher.md)

[Test environment with Kubeadm](./docs/Kubeadm.md) - TODO