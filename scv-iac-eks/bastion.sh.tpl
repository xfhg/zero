#!/bin/bash

cd /tmp || exit

# patch AMI to latest 
apt-get update && apt-get -y upgrade

# install dependencies
apt-get install unzip

# install aws-cli v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
chmod 755 /tmp/eksctl
mv /tmp/eksctl /usr/local/bin


# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod 755 kubectl
mv -v kubectl /usr/local/bin

# install helm
curl https://get.helm.sh/helm-v3.6.3-linux-amd64.tar.gz -O
tar -xzvf helm-v3.6.3-linux-amd64.tar.gz
chmod 755 linux-amd64/helm
mv -v linux-amd64/helm /usr/local/bin/

# AWS SSO config
mkdir -pv /home/ubuntu/.aws
cat << EOF > /home/ubuntu/.aws/credentials
sso_start_url = "https://scventures.awsapps.com/start
sso_region = ap-southeast-1
sso_account_id = 855703743734
sso_role_name = OleaDeveloper
EOF
chmod 0700 /home/ubuntu/.aws
chmod 0600 /home/ubuntu/.aws/credentials
chown -R ubuntu. /home/ubuntu


