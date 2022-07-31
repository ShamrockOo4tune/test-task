#!/bin/bash
# Assume operating system is CentOS-7 (according to test-task)

# Bring up network connection
nmcli con mod enp0s3 connection.autoconnect yes
nmcli con up enp0s3

# Install utilities and software
sudo yum -y install epel-release wget curl git tree 
sudo yum -y install ansible

# Create ansible project directory structure
sudo ansible-galaxy init --init-path /ansible install_software
sudo ansible-galaxy init --init-path /ansible configure_server
sudo chown $USER -R /ansible
tree -d /ansible

# tweak ansible config
cat <<EOF > /ansible/ansible.cfg
[defaults]
log_path          = /ansible/project_logs.log
inventory         = ./hosts
stdout_callback   = community.general.yaml
callbacks_enabled = ansible.posix.profile_tasks, ansible.posix.timer 
EOF


# create and inject ssh key for ansible to SRV01. Assume 'ansible' user @ 192.168.56.103 exists
ssh-keygen -t rsa -b 4096 -N '' -q -f ~/.ssh/ansible_id_rsa
ssh-copy-id -i ~/.ssh/ansible_id_rsa.pub -o StrictHostKeyChecking=no ansible@192.168.56.103 




