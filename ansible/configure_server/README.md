## configure_server  
===================  

Example server configuration tasks as per TZ.  



## Requirements  
------------  

install_software role should be deployed with a play prior colling this role   


## Role Variables  
--------------  

low priority defaults:  
DEFAULT_OWNER               : Specify the owner who will own the newly created / copied files  
DEFAULT_GROUP               : Specify the group who will own the newly created / copied files  
DEFAULT_TEST_COPY_PATH      : Defult directory to be created and files will be copied to it  
DEFAULT_SSH_CONFIG          : Default sshd config file path   

variables:
USERS:                      : Dictionary of dictionaries representing users and their  
  user1:                    : parameters that needs to be created  
    name        : user1    
    shell       : /bin/bash    
    system      : 0           
    state       : present     
    create_home : 1           

VAR_J2_FILE_NAME            : sample template file path  
SPECIAL_OWNER               : whom the file ownership will be assigned to  
NEW_HOSTNAME                : change server hostname to this value  
NEW_SSH_CONFIG              : file name for ssh config copy  


## Dependencies    
------------  

Not applicable  


## Example Playbook
----------------

[Available here: /ansible/configure_server.yaml](https://github.com/ShamrockOo4tune/test-task/blob/master/ansible/configure_server.yaml)  

## License  
-------  

none

## Author Information
------------------

Shamil Gumerov  
shamusg12345@gmail.com  
https://github.com/ShamrockOo4tune  
