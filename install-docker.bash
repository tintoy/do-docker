#!/usr/bin/env bash

set -e

# Docker install using explicit calls to Ansible modules

ansible all -m apt_key -a "id=F76221572C52609D keyserver=http://apt.dockerproject.org/gpg state=present"
ansible all -m apt_repository -a "repo='deb http://apt.dockerproject.org/repo ubuntu-trusty main' mode=644 update_cache=yes"
ansible all -m apt -a 'name=docker-engine state=present'
ansible role=master -a "docker run --rm -it mwendler/cowsay 'Hello Docker, I am a master node'"
ansible role=worker -a "docker run --rm -it mwendler/cowsay 'Hello Docker, I am a worker node'"
