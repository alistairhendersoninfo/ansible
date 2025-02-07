#!/bin/bash

# Define the base directory in /opt
BASE_DIR="/opt/ansible-playbook"
DIRECTORIES=(
  "$BASE_DIR/templates"
  "$BASE_DIR/vars"
  "$BASE_DIR/roles/my_custom_role"
  "$BASE_DIR/roles/files"
  
  "$BASE_DIR/roles/roles"
  "$BASE_DIR/roles/roles/files"
  "$BASE_DIR/roles/roles/tasks"
  "$BASE_DIR/roles/roles/templates"
  "$BASE_DIR/roles/roles/vars"
  "$BASE_DIR/roles/roles/handlers"
  "$BASE_DIR/roles/roles/defaults"
  "$BASE_DIR/roles/roles/meta"
)

# Ensure the script is run with sudo
if [[ $EUID -ne 0 ]]; then
   echo "Please run this script as root or with sudo."
   exit 1
fi

# Create directories
for dir in "${DIRECTORIES[@]}"; do
  mkdir -p "$dir"
  echo "Created directory: $dir"
done

# Create essential files
touch "$BASE_DIR/inventory.yml"
touch "$BASE_DIR/playbook.yml"
touch "$BASE_DIR/templates/config.j2"
touch "$BASE_DIR/vars/main.yml"

touch "$BASE_DIR/roles/vars/secrets.yml"
touch "$BASE_DIR/roles/files/main.yml"
touch "$BASE_DIR/roles/roles/tasks/main.yml"
touch "$BASE_DIR/roles/roles/templates/config.j2"


  
# Set appropriate permissions
chown -R $SUDO_USER:$SUDO_USER "$BASE_DIR"
chmod -R 755 "$BASE_DIR"

# Provide feedback
echo "Ansible directory structure created successfully at $BASE_DIR"
tree "$BASE_DIR"
