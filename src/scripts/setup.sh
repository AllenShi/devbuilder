#!/bin/bash

# Step 1: create group and user
printf "Step 1: create group and user\n"
if id devops &>/dev/null; then
	printf "devops user exists\n"
else
    groupadd devopsgrp
    useradd -m -g devopsgrp devops
fi

# Step 2: add into sudoer group 
printf "Step 2: add into sudoer group\n" 
echo "devops  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/devops

# Step 3: yum update
printf "Step 3: yum update (omitted now)\n"
# yum -y update

# Step 4: switch to devops
printf "Step 4: switch to devops\n"
su -l -c runAsNonroot.sh devops

