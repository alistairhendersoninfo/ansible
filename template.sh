#!/bin/bash

# Define the base directory in /opt
BASE_DIR="/opt/base_playbook"
DIRECTORIES=(
  "$BASE_DIR/templates"
  "$BASE_DIR/vars"
  "$BASE_DIR/files"
  "$BASE_DIR/tasks"
  "$BASE_DIR/my_custom_role"
  "$BASE_DIR/group_vars"
  "$BASE_DIR/group_vars/all"
  "$BASE_DIR/roles"
  "$BASE_DIR/roles/ToCopy"
  "$BASE_DIR/roles/ToCopy/files"
  "$BASE_DIR/roles/ToCopy/group_vars/"
  "$BASE_DIR/roles/ToCopy/group_vars/all"
  "$BASE_DIR/roles/ToCopy/tasks"
  "$BASE_DIR/roles/ToCopy/templates"
  "$BASE_DIR/roles/ToCopy/vars"
  "$BASE_DIR/roles/ToCopy/handlers"
  "$BASE_DIR/roles/ToCopy/defaults"
  "$BASE_DIR/roles/ToCopy/meta"
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

touch "$BASE_DIR/roles/ToCopy/vars/main.yml"
touch "$BASE_DIR/roles/ToCopy/tasks/main.yml"
touch "$BASE_DIR/roles/ToCopy/handlers/main.yml"
touch "$BASE_DIR/roles/ToCopy/templates/config.j2"


touch "$BASE_DIR/roles/ToCopy/tasks/main.yml"
touch "$BASE_DIR/roles/ToCopy/templates/config.j2"
touch "$BASE_DIR/roles/ToCopy/vars/main.yml"
touch "$BASE_DIR/roles/ToCopy/handlers/main.yml"
touch "$BASE_DIR/roles/ToCopy/defaults/main.yml"
touch "$BASE_DIR/roles/ToCopy/meta/main.yml"

# Create a directory for the scripts
mkdir $BASE_DIR/creationscripts
cp *.sh $BASE_DIR/creationscripts
  
# Set appropriate permissions
chown -R $SUDO_USER:$SUDO_USER "$BASE_DIR"
chmod -R 755 "$BASE_DIR"

# Provide feedback
echo "Ansible directory structure created successfully at $BASE_DIR"
tree "$BASE_DIR"
