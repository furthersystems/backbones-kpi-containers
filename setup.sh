#!/bin/bash -ex

# MIT License
#
# Copyright (c) 2021 FurtherSystem Co.,Ltd.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html
# https://www.elastic.co/guide/en/kibana/current/docker.html

curl https://get.docker.com/ -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
curl -L https://github.com/docker/compose/releases/download/1.28.6/docker-compose-Linux-x86_64 > docker-compose
chmod +x docker-compose
sudo mv docker-compose /usr/local/bin/
sudo firewall-cmd --add-port=9200/tcp --permanent
sudo firewall-cmd --add-port=9201/tcp --permanent
sudo firewall-cmd --add-port=9202/tcp --permanent
sudo firewall-cmd --add-port=5601/tcp --permanent
sudo firewall-cmd --reload
sudo rm -rf /var/lib/docker/data/fsbones/
sudo mkdir -p /var/lib/docker/data/bones/es/usr/local/scripts
sudo mkdir -p /var/lib/docker/data/bones/es/usr/local/imports
sudo mkdir -p /var/lib/docker/data/bones/kibana/usr/local/scripts
sudo chcon -Ru system_u /var/lib/docker/data/bones
sudo chcon -Rt svirt_sandbox_file_t /var/lib/docker/data/bones
sudo systemctl restart docker
sudo systemctl enable docker
sudo systemctl start docker

docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml up
