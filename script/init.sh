#!/bin/bash

echo '####################'
echo '# Install apt deps #'
echo '####################'
add-apt-repository -y ppa:x2go/stable
apt update
apt --assume-yes upgrade
curl -fsSL https://deb.nodesource.com/setup_12.x | bash -
apt install --assume-yes awscli unzip nodejs firefox docker.io docker-compose x2goserver x2goserver-xsession

echo '################'
echo '# Install yarn #'
echo '################'
npm i -g yarn

echo '#####################'
echo '# Install terraform #'
echo '#####################'
mkdir -p /opt/hashicorp
curl -L https://releases.hashicorp.com/terraform/1.0.6/terraform_1.0.6_linux_amd64.zip -o "/opt/hashicorp/terraform.zip"
unzip "/opt/hashicorp/terraform.zip" -d "/opt/hashicorp"
rm "/opt/hashicorp/terraform.zip"
ln -s /opt/hashicorp/terraform /usr/local/bin/terraform

echo '#####################'
echo '# Install aws-vault #'
echo '#####################'
mkdir -p /opt/99designs
curl -L https://github.com/99designs/aws-vault/releases/download/v6.3.1/aws-vault-linux-amd64 -o "/opt/99designs/aws-vault"
chmod +x "/opt/99designs/aws-vault"
ln -s "/opt/99designs/aws-vault" /usr/local/bin/aws-vault
echo "export AWS_VAULT_BACKEND=file" >> /home/ubuntu/.profile

echo '###################'
echo '# Prepare init.sh #'
echo '###################'
echo '#!/bin/bash' > /home/ubuntu/init.sh
echo 'read -s -p "Passphrase: " passphrase' >> /home/ubuntu/init.sh
echo 'curl -o - -L https://raw.githubusercontent.com/iknowcss/code-cloud/master/script/homeinit.crypt.sh | base64 -d | gpg -d --passphrase "$passphrase" --batch > /home/ubuntu/homeinit.sh' >> /home/ubuntu/init.sh
echo 'chmod +x /home/ubuntu/homeinit.sh' >> /home/ubuntu/init.sh
echo '/home/ubuntu/homeinit.sh' >> /home/ubuntu/init.sh
echo 'rm /home/ubuntu/init.sh' >> /home/ubuntu/init.sh
chown ubuntu:ubuntu /home/ubuntu/init.sh
chmod +x /home/ubuntu/init.sh

echo '#########'
echo '# Done! #'
echo '#########'
