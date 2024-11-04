#!/bin/bash

echo -e "Building image 'ubuntu-python3:20.04'"
docker build ./docker/ -t ubuntu-python3:20.04
echo -e "\n\n"



echo -e "Run container:"
docker run -it -d --name centos7 centos:7
echo -e "\n"

echo -e "Run container:"
docker run -it -d --name ubuntu ubuntu-python3:20.04
echo -e "\n"

echo -e "Run container:"
docker run -it -d --name fedora-container pycontribs/fedora
echo -e "\n\n"



echo -e "Run playbook"
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
echo -e "\n\n"



echo -e "Stoped container:"
docker container stop centos7
echo -e "\n"

echo -e "Stoped container:"
docker container stop ubuntu
echo -e "\n"

echo -e "Stoped container:"
docker container stop fedora-container
