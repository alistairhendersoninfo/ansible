#!/bin/bash

# Define the base directory in /opt
BASE_DIR="/opt/base_playbook"
DIRECTORIES=(
  "$BASE_DIR/templates"
  "$BASE_DIR/vars"
  "$BASE_DIR/roles"
  "$BASE_DIR/files"
  "$BASE_DIR/tasks"
  "$BASE_DIR/my_custom_role"
  "$BASE_DIR/group_vars"
  "$BASE_DIR/group_vars/all"
  "$BASE_DIR/roles/files"
  "$BASE_DIR/roles/group_vars"
  "$BASE_DIR/roles/group_vars/all"
  "$BASE_DIR/roles/tasks"
  "$BASE_DIR/roles/templates"
  "$BASE_DIR/roles/vars"
  "$BASE_DIR/roles/handlers"
  "$BASE_DIR/roles/defaults"
  "$BASE_DIR/roles/meta"
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


cp *.sh $BASE_DIR
  
# Set appropriate permissions
chown -R $SUDO_USER:$SUDO_USER "$BASE_DIR"
chmod -R 755 "$BASE_DIR"

# Provide feedback
echo "Ansible directory structure created successfully at $BASE_DIR"
tree "$BASE_DIR"
