#!/bin/bash

# Define the inventory file
INVENTORY_FILE="inventory.yml"

# Prompt user for hostname and allow editing
read -e -p "Enter hostname: " HOSTNAME
read -e -p "Enter IP address: " IP_ADDRESS

# Create the inventory file with the given structure
cat <<EOF > "$INVENTORY_FILE"
all:
  hosts:
    device1:
      ansible_host: ${IP_ADDRESS}
      hostname: ${HOSTNAME}
      ansible_user: rsadmin
      ansible_password: "{{ ansible_password }}"
      ansible_become_password: "{{ ansible_password }}"
      ansible_become: true
      ansible_become_method: sudo
EOF

echo "Inventory file created successfully:"
cat "$INVENTORY_FILE"


