#!/bin/bash
BASE_DIR="/opt/base_playbook"
cd $BASE_DIR


# Define the playbook content
cat <<EOF > example_playbook.yml
---
- name: Basic Server Configuration
  hosts: all
  gather_facts: yes
  become: yes

  vars_files:
    - group_vars/all/secrets.yml

############ This is if you want to use roles  ###############
  roles:
    - common
    - webserver

########### This is if you just want to create a simple playbook with no roles  ###################
  tasks:
    - name: Ensure Apache is installed
      ansible.builtin.apt:
        name: apache2
        state: present
      notify: Restart Apache
      register: apache_result
      ignore_errors: yes

    - name: Log Apache installation status
      ansible.builtin.debug:
        msg: "Apache installation status: {{ apache_result }}"

    - name: Fail if Apache installation failed
      ansible.builtin.fail:
        msg: "Apache installation failed, please check logs."
      when: apache_result is failed

###########  This is called from the notify element of the task, and the name must match #####################
  handlers:
    - name: Restart Apache
      ansible.builtin.service:
        name: apache2
        state: restarted
      register: restart_result

    - name: Log Apache restart status
      ansible.builtin.debug:
        msg: "Apache restart status: {{ restart_result }}"
EOF

# Confirm script execution
echo "Ansible playbook 'example_playbook.yml' has been created successfully."
