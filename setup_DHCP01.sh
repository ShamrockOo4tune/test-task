#!/bin/bash
# Assume operating system is CentOS-7 (according to test-task)

# Bring up network connection
nmcli con mod enp0s3 connection.autoconnect yes
nmcli con up enp0s3

# Install utilities and software
sudo yum -y install epel-release wget curl git tree 
sudo yum -y install ansible

# add ansible-playbook executable shortcut
sudo ln -s $(which ansible-playbook) /usr/bin/ansible-playbook || true

# Create ansible project directory structure
sudo ansible-galaxy init --init-path /ansible install_software
sudo ansible-galaxy init --init-path /ansible configure_server
sudo chown $USER -R /ansible
tree -d /ansible

# Logs directory and access
sudo mkdir -p /var/log/ansible
sudo chown $USER /var/log/ansible

# Tweak ansible config
cat <<EOF > ~/.ansible.cfg
[defaults]
log_path          = /var/log/project_logs.log
stdout_callback   = yaml
callbacks_enabled = ansible.posix.profile_tasks, ansible.posix.timer 
EOF

# create and inject ssh key to SRV01. Assume privileged 'ansible' user @ 192.168.56.103 exists
ssh-keygen -t rsa -b 4096 -N '' -q -f ~/.ssh/ansible_id_rsa
ssh-copy-id -i ~/.ssh/ansible_id_rsa.pub -o StrictHostKeyChecking=no ansible@192.168.56.103 

# Clone source code repo
git clone https://github.com/ShamrockOo4tune/test-task.git

# Sync ansible roles to /ansible/ (provide roles path according to TZ)
rsync -au "./test-task/ansible/install_software/" "/ansible/install_software/"
rsync -au "./test-task/ansible/configure_server/" "/ansible/configure_server/"
