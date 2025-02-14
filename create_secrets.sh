#!/bin/bash

BASE_DIR=$(pwd | awk -F'/' '{print "/"$2"/"$3}')
#echo "$BASE_DIR"

# Define the group where secrets should be stored (Modify as needed)
GROUP="all"  # Change this to webservers, dbservers, etc.
SECRETS_FILE="group_vars/$GROUP/secrets.yml"

# Ensure the group_vars directory exists
mkdir -p "$BASE_DIR/group_vars/$GROUP"
#echo "make $BASE_DIR/group_vars/$GROUP"
#echo "the secrests files is $SECRETS_FILE"	

# Prompt for the Ansible Vault password
read -sp "Enter the password to encrypt the file: " VAULT_PASS
echo $VAULT_PASS > .vault_password

# Notify user of common input expectations
echo "Enter the secrets (key: value format)."
echo "** Typically, for logon credentials this would be: ansible_password: LOGONPASSWORD **"
echo "###################################"
echo "Type 'done' when finished."
echo "###################################"

# Create a temporary YAML file
TEMP_FILE=$(mktemp)
#echo "The temp file is $TEMP_FILE"
echo "---" > $TEMP_FILE

while true; do
    read -p "Secret (example: ansible_password: LOGONPASSWORD): " SECRET
    if [[ "$SECRET" == "done" ]]; then
        break
    fi
    echo "$SECRET" >> $TEMP_FILE
done
#echo "Done creating the files now calling the ansible-vault command"

# Encrypt the file and store it in the group_vars directory
ansible-vault encrypt --vault-password-file=.vault_password --output=$BASE_DIR/$SECRETS_FILE $TEMP_FILE
rm .vault_password $TEMP_FILE

echo "Encrypted secrets.yml stored in $BASE_DIR/$SECRETS_FILE successfully."
