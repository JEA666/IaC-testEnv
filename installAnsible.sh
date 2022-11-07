#!/bin/bash

# Check if ansible is installed and install if not.
if [ -x "$command -v ansible"  ]; then
  printf "\e[1;32m%-6s\e[m\n" "Ansible is allredy installed"
else
  printf "\e[1;32m%-6s\e[m\n" "Installing Ansible"
  sudo apt install -y ansible
fi

# Start Ansible script
#printf "\e[1;32m%-6s\e[m\n" "Starting Ansible script .."
#ansible-playbook ansible/localHostProvisioning.yml --ask-become-pass

