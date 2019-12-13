#!/bin/bash
sudo yum update -y
sudo yum install git -y
cd /tmp
sudo git clone https://github.com/matheusLeaao/ansible-study.git
cd /tmp/ansible-study/AnsibleExamples/install-lamp
sudo yum install ansible -y
ansible-playbook main.yml -i hosts
echo "end of user_data module"