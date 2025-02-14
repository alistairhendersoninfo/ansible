#!/bin/bash

# Define the inventory file
INVENTORY_FILE="inventory.yml"

# Find the last device number
LAST_DEVICE=$(grep -oP '^    device\d+:' "$INVENTORY_FILE" | tail -n 1 | grep -oP '\d+')
NEW_DEVICE=$((LAST_DEVICE + 1))

# Prompt user for new hostname and allow editing
read -e -p "Enter hostname: " HOSTNAME
read -e -p "Enter IP address: " IP_ADDRESS

# Define the new entry
NEW_ENTRY=$(cat <<EOF
    device${NEW_DEVICE}:
      ansible_host: ${IP_ADDRESS}
      hostname: ${HOSTNAME}
      ansible_user: rsadmin
      ansible_password: "{{ ansible_password }}"
      ansible_become_password: "{{ ansible_password }}"
      ansible_become: true
      ansible_become_method: sudo
EOF
)

# Append to the inventory file
echo "$NEW_ENTRY" >> "$INVENTORY_FILE"

echo "New device entry added successfully:"
echo "$NEW_ENTRY"

