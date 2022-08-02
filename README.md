# test-task  

# Структура репозитория:  

.  
├── ansible  
│   ├── ansible.cfg  
│   ├── configure_server  
│   │   ├── defaults  
│   │   │   └── main.yml  
│   │   ├── handlers  
│   │   │   └── main.yml  
│   │   ├── README.md  
│   │   ├── tasks  
│   │   │   └── main.yml  
│   │   ├── templates  
│   │   │   └── users.txt.j2  
│   │   └── vars  
│   │       └── main.yml  
│   ├── configure_server.yaml  
│   ├── group_vars  
│   │   └── end_servers  
│   ├── hosts  
│   ├── install_software  
│   │   ├── defaults  
│   │   │   └── main.yml  
│   │   ├── README.md  
│   │   ├── tasks  
│   │   │   └── main.yml  
│   │   └── vars  
│   │       └── main.yml  
│   └── install_software.yaml  
├── create_vms.sh  
├── README.md &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <--- Вы здесь           
├── screenshots-and-logfiles  
│   ├── ansible.log  
│   ├── ansible_on_DHCP01.png  
│   └── vbox_network_solved.png  
├── setup_DHCP01.sh  
└── tasks.txt  

# Тестовое задание для Innostage  

Исходные данные представлены в файле: tasks.txt  в корне репозитория


# Воспроизведение решения:

При установленной системе виртуализации VirtualBox, запустить сценарий create_vms.sh в корне репозитория  
Установить ОС на вируальных машинах SRV01 и DHCP01. На сервере SRV01 создать технического пользователя  
ansible с административными правами. 

Выполнить установочный сценарий setup_DHCP01.sh на виртуальной машине DHCP01  
Будет запрошен пароль пользователя ansible@SRV01 для проброса внутрь открытого ключа  

Тем же пользователем, который исполнял  setup_DHCP01.sh на виртуальной машине DHCP01 запустить выполнение  
сценария ansible-playbook, расположенного по пути ~/test-task/ansible/install_software.yaml  

Затем можно будет запустить следующий сценарий (configure_server) там же  

Наблюдать результаты на экране


# Примеры выполнения задания
Доступны снимки экрана и файл логов в папке screenshots-and-logfiles в корне проекта
