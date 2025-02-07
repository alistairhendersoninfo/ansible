#!/bin/bash
BASE_DIR="/opt/base_playbook"

# Define the group where secrets.yml is stored
GROUP="all"  # Change this to webservers, dbservers, etc.
SECRETS_FILE="$BASE_DIR/group_vars/$GROUP/secrets.yml"

# Ensure the secrets file exists
if [[ ! -f "$SECRETS_FILE" ]]; then
    echo "Error: Encrypted secrets file not found at $SECRETS_FILE"
    exit 1
fi

# Prompt for the Ansible Vault password
read -sp "Enter vault password: " VAULT_PASS
echo
echo $VAULT_PASS > .vault_password

# Edit the encrypted file
ansible-vault edit --vault-password-file=.vault_password "$SECRETS_FILE"

# Remove the temporary password file for security
rm .vault_password

echo "Secrets file successfully edited."
