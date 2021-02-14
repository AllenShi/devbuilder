#!/bin/bash

# Step 1: create group and user
groupadd devopsgrp
useradd -m -g devopsgrp devops

# Step 2: add into sudoer group 
echo "devops  ALL=(ALL)       NOPASSWD: ALL" >> /ect/sudoers.d/devops

# Step 3: yum update
yum -y update

# Step 4: switch to devops
su -l devops

# Step 5: ssh-keygen
ssh-keygen -f id_rsa -N ""

# Step 6: install git
sudo yum install git

# Step 7: install gcc tool chains
sudo yum install gcc clang cmake
sudo tmux

# Step 8: install rustlang
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cat > $HOME/.cargo/config >>EOF
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
EOF
echo "export PATH=$HOME/.cargo/bin:$PATH" >> $HOME/.bash_profile
source $HOME/.bash_profile
rustc --version

# Step 9: install golang
echo "export GOPROXY=https://mirrors.aliyun.com/goproxy/" >> $HOME/.bash_profile
source $HOME/.bash_profile
wget https://golang.org/dl/go1.15.8.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.15.8.linux-amd64.tar.gz
echo "export PATH=/usr/local/go/bin:$PATH" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

# Step 10: install Java SDK
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/15.0.2%2B7/0d1cfde4252546c6931946de8db48ee2/jdk-15.0.2_linux-x64_bin.rpm
sudo yum remove java -y && yum localinstall jdk-15.0.2_linux-x64_bin.rpm -y 
sudo alternatives --display java

# Step 11: create workspace for different projects
mkdir -p $HOME/projects/rustlangws/
mkdir -p $HOME/projects/golangws/
mkdir -p $HOME/projects/javalangws/
