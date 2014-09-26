#!/bin/bash

# Create the directory needed to run the sshd daemon
mkdir /var/run/sshd 

ANDROID_HOME=/home/android
AUTHORIZED_KEYS=$ANDROID_HOME/.ssh/authorized_keys
SSH_DIR=`dirname "$AUTHORIZED_KEYS"`

# Add docker user and generate a random password with 12 characters that includes at least one capital letter and number.
#DOCKER_PASSWORD=`pwgen -c -n -1 12`
#echo User: docker Password: $DOCKER_PASSWORD
#DOCKER_ENCRYPYTED_PASSWORD=`perl -e 'print crypt('"$DOCKER_PASSWORD"', "aa"),"\n"'`
#useradd -m -d /home/docker -p $DOCKER_ENCRYPYTED_PASSWORD docker
#sed -Ei 's/adm:x:4:/docker:x:4:docker/' /etc/group
#adduser docker sudo

groupadd android
useradd -m -d $ANDROID_HOME -s /bin/bash -g android android
adduser android sudo
echo "android:android" | chpasswd

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"
chown android:android "$SSH_DIR"
cat /src/ssh/id_rsa.pub >> "$AUTHORIZED_KEYS"

# restarts the xdm service
/etc/init.d/xdm restart

# Start the ssh service
/usr/sbin/sshd -D
