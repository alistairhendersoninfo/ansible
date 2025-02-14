#!/bin/bash
# Prompt for the inventory file path with editing enabled
read -e -p "Enter the inventory filename (default: inventory.yml): " -i "inventory.yml" INVENTORY_FILENAME
# Define the inventory file path
BASE_DIR=$(pwd | awk -F'/' '{print "/"$2"/"$3}')

INVENTORY_FILE="$BASE_DIR/$INVENTORY_FILENAME"


# Prompt user for inventory file
#read -p "Enter the inventory filename (default: inventory.yml): " -i "inventory.yml"  INVENTORY_FILE
#INVENTORY_FILE=${INVENTORY_FILE:-inventory.yml}

# Check if file exists
if [ ! -f "$INVENTORY_FILE" ]; then
  echo "Error: Inventory file $INVENTORY_FILE not found!"
  exit 1
fi




# Extract unique IP addresses (handles different inventory formats)
IP_ADDRESSES=$(grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$INVENTORY_FILE" | sort -u)

# Ensure known_hosts file exists
rm -f  ~/.ssh/known_hosts



mkdir -p ~/.ssh
touch ~/.ssh/known_hosts
chmod 600 ~/.ssh/known_hosts

# Loop through IPs and add to known_hosts
for IP in $IP_ADDRESSES; do
  echo "Adding SSH key for $IP to known_hosts..."
  ssh-keyscan -H "$IP" >> ~/.ssh/known_hosts 2>/dev/null
  if [ $? -eq 0 ]; then
    echo "Successfully added $IP"
  else
    echo "Failed to add $IP"
  fi
done

echo "SSH keys added successfully!"
