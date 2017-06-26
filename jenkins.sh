#!/bin/bash

/solutions/install_packages.sh

echo Instalando java ...
if [ ! -f /solutions/app/java/bin/java ]; then
	wget -P /solutions/app/ "https://github.com/nfqSolutionsDocker/jenkins/raw/2.67-jdk8-python3.6.1/installations/aa"
	wget -P /solutions/app/ "https://github.com/nfqSolutionsDocker/jenkins/raw/2.67-jdk8-python3.6.1/installations/ab"
	wget -P /solutions/app/ "https://github.com/nfqSolutionsDocker/jenkins/raw/2.67-jdk8-python3.6.1/installations/ac"
	wget -P /solutions/app/ "https://github.com/nfqSolutionsDocker/jenkins/raw/2.67-jdk8-python3.6.1/installations/ad"
	cat /solutions/app/aa > /solutions/app/jdk-${JAVA_VERSION}-linux-x64.tar.gz
	cat /solutions/app/ab >> /solutions/app/jdk-${JAVA_VERSION}-linux-x64.tar.gz
	cat /solutions/app/ac >> /solutions/app/jdk-${JAVA_VERSION}-linux-x64.tar.gz
	cat /solutions/app/ad >> /solutions/app/jdk-${JAVA_VERSION}-linux-x64.tar.gz
	tar -xvzf /solutions/app/jdk-${JAVA_VERSION}-linux-x64.tar.gz -C /solutions/app/
	chmod -R 777 $(ls -d /solutions/app/jdk*/)
	ln -sf $(ls -d /solutions/app/jdk*/) /solutions/app/java
fi

echo Instalando python ...
if [ ! -f /usr/local/bin/python3 ]; then
	wget -P /usr/src/ "https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz"
	tar -xzf /usr/src/Python-3.6.1.tgz -C /usr/src/
	/usr/src/Python-3.6.1/configure
	make install -I /usr/src/Python-3.6.1/
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