#!/bin/bash

# Define the inventory file path
INVENTORY_FILE="/opt/ansible-playbook/inventory.yml"

# Parse the IP address from the inventory file
IP_ADDRESS=$(grep -oP '(?<=ansible_host=)[0-9\.]+' "$INVENTORY_FILE")

# Check if IP was found
if [ -z "$IP_ADDRESS" ]; then
  echo "Error: Unable to parse IP address from $INVENTORY_FILE"
  exit 1
fi

echo "Adding SSH key for $IP_ADDRESS to known_hosts..."

# Retrieve the SSH key and append to known_hosts
ssh-keyscan -H "$IP_ADDRESS" >> ~/.ssh/known_hosts 2>/dev/null

# Verify if the key was added successfully
if ssh-keygen -F "$IP_ADDRESS" > /dev/null; then
  echo "SSH key for $IP_ADDRESS added successfully to known_hosts."
else
  echo "Failed to add SSH key for $IP_ADDRESS."
  exit 1
fi
