#!/bin/bash

# Check if virtualbox executable is available or install it
if ! [ -x "$(command -v VBoxManage)" ]; 
  then echo -e "No virtualbox cli has been foud on PATH \nInsatlling VBoxManage...";
  case $(cat /etc/os-release | awk -FNAME= 'NR == 1 {print $2}' | tr -d \") in
    Ubuntu)       sudo apt update;
                  sudo apt install virtualbox -y;;
 
    'CentOS Linux') sudo yum install kernel-devel kernel-devel-$(uname -r) kernel-headers kernel-headers-$(uname -r) make patch gcc -y;
                  sudo wget https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -P /etc/yum.repos.d;
                  sudo yum install VirtualBox-6.1 -y ;;

    *)            echo 'Please refer to official installation guidelines: https://www.virtualbox.org/manual/UserManual.html#intro-installing' ;
                  exit 1 ;;
  esac
fi
VBoxManage --version


# Download CenOS7 image 
mkdir -p ~/iso_images 
if ! [ -f "$HOME/iso_images/CentOS-7-x86_64-Minimal-2009.iso" ];
  then echo 'Press Ctrl+C to skip. Downloading CentOS image...'; 
  wget http://mirror.yandex.ru/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso -P ~/iso_images;
fi


# Terraform
if ! [ -x "$(command -v terraform)" ]; 
  then echo -e "No terraform execurable has been foud on PATH \nInsatlling terraform...";
  case $(uname -m) in
    i386 | i686)   ARCHITECTURE='386' ;;
    x86_64)        ARCHITECTURE='amd64' ;;
    arm)           dpkg --print ARCHITECTURE | grep -q 'arm64' && ARCHITECTURE='arm64' || ARCHITECTURE='arm' ;;
    *)             echo 'Unable to determine system ARCHITECTURE'; exit 1 ;;
  esac
  echo "Architecure: $ARCHITECTURE"
  wget -nc -q https://releases.hashicorp.com/terraform/1.2.5/terraform_1.2.5_linux_${ARCHITECTURE}.zip
  unzip -o ./terraform_1.2.5_linux_${ARCHITECTURE}.zip && rm terraform_1.2.5_linux_${ARCHITECTURE}.zip
  sudo mv ./terraform /usr/local/bin/terraform
fi
terraform -v

# Ansible
if ! [ -x "$(command -v ansible)" ]; 
  then echo -e "No ansible execurable has been foud on PATH \nInsatlling ansible...";
  case $(cat /etc/os-release | awk -FNAME= 'NR == 1 {print $2}' | tr -d \") in
    Ubuntu)       sudo apt update;
                    sudo apt install software-properties-common;
                    sudo add-apt-repository --yes --update ppa:ansible/ansible;
                    sudo apt install ansible ;;

    'CentOS Linux') sudo yum install epel-release ansible ;;

    *)              echo 'Please refer to official installation guideline: https://docs.ansible.com/ansible/latest/installation_guide/index.html' ;
                    exit 1 ;;
  esac
fi
ansible --version