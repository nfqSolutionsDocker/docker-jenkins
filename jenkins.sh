#!/bin/bash

/solutions/install_packages.sh

echo Instalando java ...
if [ ! -f /solutions/app/java/bin/java ]; then
	wget -P /solutions/app/ --no-cookies --no-check-certificate --header \
    	"Cookie: oraclelicense=accept-securebackup-cookie" \
    	"http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b06/jdk-${JAVA_VERSION}-linux-x64-rpm.bin"
    chmod +x /solutions/app/jdk-6u45-linux-x64-rpm.bin
    /solutions/app/jdk-6u45-linux-x64-rpm.bin
    chmod -R 777 $(ls -d /usr/java/jdk*/)
    ln -sf $(ls -d /usr/java/jdk*/) /solutions/app/java
fi

echo Instalando jenkins ...
if [ ! -f /solutions/app/jenkins/jenkins.war ]; then
	mkdir -p /solutions/app/jenkins
	mkdir -p /solutions/app/jenkins/ref/init.groovy.d
	cp /solutions/init.groovy /solutions/app/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy
	curl -fsSL ${JENKINS_URL} -o /solutions/app/jenkins/jenkins.war && echo "${JENKINS_SHA}  /solutions/app/jenkins/jenkins.war" | sha1sum -c -
	chmod -R 777 /solutions/app/jenkins
fi

java $JAVA_OPTS -jar /solutions/app/jenkins/jenkins.war