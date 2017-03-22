#!/bin/bash

/solutions/install_packages.sh

echo Instalando java ...
if [ ! -f /solutions/app/java/bin/java ]; then
	wget -P /solutions/app/ --no-cookies --no-check-certificate --header \
    	"Cookie: oraclelicense=accept-securebackup-cookie" \
    	"http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b14/jdk-${JAVA_VERSION}-linux-x64.tar.gz"
	tar -xvzf /solutions/app/jdk-${JAVA_VERSION}-linux-x64.tar.gz -C /solutions/app/
	chmod -R 777 $(ls -d /solutions/app/jdk*/)
	ln -sf $(ls -d /solutions/app/jdk*/) /solutions/app/java
fi

#echo Instalando servidor ssh ...
#if [ ! -f /usr/sbin/sshd ]; then
#	yum install -y openssh-server
#	mkdir /var/run/sshd
#	ssh-keygen -t rsa -f /solutions/app/local.pem -N ''
#	mkdir /root/.ssh
#	cat /solutions/app/local.pem.pub >> /root/.ssh/authorized_keys
#	sed -i "s/HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/solutions\/app\/local.pem/g" /etc/ssh/sshd_config
#	sed -i "s/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/g" /etc/ssh/sshd_config
#	sed -i "s/HostKey \/etc\/ssh\/ssh_host_ed25519_key/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/g" /etc/ssh/sshd_config
#	sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
#	sed -i "s/GSSAPIAuthentication yes/GSSAPIAuthentication no/g" /etc/ssh/sshd_config
#	yum install -y xorg-x11-*
#fi

echo Instalando Escritorio GNOME ...
yum -y groups install "GNOME Desktop"

echo Instalando firefox ...
if [ ! -f /usr/bin/firefox ]; then
	cd /etc/yum.repos.d
	curl -O https://winswitch.org/downloads/CentOS/winswitch.repo
	yum repolist
	yum install -y xpra
	yum install -y firefox
fi

echo Instalando jenkins ...
if [ ! -f /solutions/app/jenkins/jenkins.war ]; then
	mkdir -p /solutions/app/jenkins
	mkdir -p /solutions/app/jenkins/ref/init.groovy.d
	cp /solutions/init.groovy /solutions/app/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy
	curl -fsSL ${JENKINS_URL} -o /solutions/app/jenkins/jenkins.war && echo "${JENKINS_SHA}  /solutions/app/jenkins/jenkins.war" | sha1sum -c -
	chmod -R 777 /solutions/app/jenkins
fi

#/usr/sbin/sshd -D &
java $JAVA_OPTS -jar /solutions/app/jenkins/jenkins.war