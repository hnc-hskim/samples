echo "Install OS tools"
sudo yum -y -q -e 0 install  jq moreutils nmap > /dev/null
echo "Update OS tools"
sudo yum update -y > /dev/null 

echo "Setup kubectl"
if [ ! `which kubectl 2> /dev/null` ]; then
  echo "Install kubectl"
  curl --silent -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl  > /dev/null
  chmod +x ./kubectl
  sudo mv ./kubectl  /usr/local/bin/kubectl > /dev/null
  kubectl completion bash >>  ~/.bash_completion
fi 

if [ ! `which helm 2> /dev/null` ]; then
  echo "helm"
  wget -q https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz > /dev/null
  tar -zxf helm-v3.5.4-linux-amd64.tar.gz
  sudo mv linux-amd64/helm /usr/local/bin/helm > /dev/null
  rm -rf helm-v3.5.4-linux-amd64.tar.gz linux-amd64
fi
echo "add helm repos"
helm repo add eks https://aws.github.io/eks-charts

if [ ! `which kubectx 2> /dev/null` ]; then
  echo "kubectx"
  sudo git clone -q https://github.com/ahmetb/kubectx /opt/kubectx > /dev/null
  sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
  sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
fi
#
echo "ssh key"
if [ ! -f ~/.ssh/id_rsa ]; then
  mkdir -p ~/.ssh
  ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""
  chmod 600 ~/.ssh/id*
fi
#
echo "ssm cli add on"
curl --silent "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm"
sudo yum install -y session-manager-plugin.rpm > /dev/null
rm -f ~/environment/session-manager-plugin.rpm
#
echo "install tfsec ..."
wget -q https://github.com/aquasecurity/tfsec/releases/download/v0.56.0/tfsec-linux-amd64
sudo mv tfsec-linux-amd64 /usr/bin/tfsec
sudo chmod 755 /usr/bin/tfsec 
#
# cleanup key_pair if already there
aws ec2 delete-key-pair --key-name "eksworkshop" > /dev/null

echo "Verify ...."
for command in jq aws wget kubectl terraform eksctl helm kubectx
  do
    which $command &>/dev/null && echo "$command in path" || echo "$command NOT FOUND"
  done


this=`pwd`
#echo "sample apps"
cd ~/environment

echo "Enable bash_completion"
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
echo "alias tfb='terraform init && terraform plan -out tfplan && terraform apply tfplan && terraform init -force-copy'" >> ~/.bash_profile
echo "alias aws='/usr/local/bin/aws'" >> ~/.bash_profile
source ~/.bash_profile
#
echo "setup tools run" >> ~/setup-tools.log
cd $this
#
# final checks - run check.sh
#