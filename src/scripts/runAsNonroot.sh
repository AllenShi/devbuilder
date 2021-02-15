#!/bin/bash

# Step 5: ssh-keygen
printf "Step 5: ssh-keygen\n"
printf "Current HOME is $HOME, current user is $(whoami)\n"
[ ! -f ~/.ssh/id_rsa ] && ssh-keygen -f id_rsa -N ""

# Step 6: install git
printf "Step 6: install git\n"
sudo yum install -y git

# Step 7: install gcc tool chains
printf "Step 7: install gcc tool chains\n"
sudo yum install -y gcc clang cmake
sudo yum install -y tmux

# Step 8: install rustlang
printf "Step 8: install rustlang\n"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cat > $HOME/.cargo/config <<EOF
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
printf "Step 9: install golang\n"
echo "export GOPROXY=https://mirrors.aliyun.com/goproxy/" >> $HOME/.bash_profile
source $HOME/.bash_profile
# wget https://golang.org/dl/go1.15.8.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf ~/go1.15.8.linux-amd64.tar.gz
echo "export PATH=/usr/local/go/bin:$PATH" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

# Step 10: install Java SDK
printf "Step 10: install Java SDK\n"
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/15.0.2%2B7/0d1cfde4252546c6931946de8db48ee2/jdk-15.0.2_linux-x64_bin.rpm
sudo yum remove java -y && yum localinstall jdk-15.0.2_linux-x64_bin.rpm -y 
sudo alternatives --display java
java --version

# Step 11: create workspace for different projects
printf "Step 11: create workspace for different projects\n"
mkdir -p $HOME/projects/rustlangws/
mkdir -p $HOME/projects/golangws/
mkdir -p $HOME/projects/javalangws/
