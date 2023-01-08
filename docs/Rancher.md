# Rancher

## Step 1

DOESN'T WORK WITH ROOTLESS DOCKER

Rancher command center!

    docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged --name=rancher rancher/rancher:latest
    docker logs rancher 2>&1 | grep "Bootstrap Password:"


   
## Step 2

Connect VM to rancher

    # Find VM ip
    virsh net-dhcp-leases default

ssh username and password is ubuntu

## Step 3

To destroy your environment

    terraform destroy
