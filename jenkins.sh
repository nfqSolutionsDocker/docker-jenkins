#!/bin/bash

echo Instalando java ...
if [ ! -f /home/solutions/app/java/bin/java ]; then
	wget -P /home/solutions/app/ --no-cookies --no-check-certificate --header \
    	"Cookie: oraclelicense=accept-securebackup-cookie" \
    	"http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b15/jdk-${JAVA_VERSION}-linux-x64.tar.gz"
	tar -xvzf /home/solutions/app/jdk-${JAVA_VERSION}-linux-x64.tar.gz -C /home/solutions/app/
	chmod -R 777 $(ls -d /home/solutions/app/jdk*/)
	ln -sf $(ls -d /home/solutions/app/jdk*/) /home/solutions/app/java
fi

echo Instalando maven ...
if [ ! -f /home/solutions/app/maven/bin/mvn ]; then
	wget -P /home/solutions/app/ "http://apache.rediris.es/maven/maven-3/${M2_VERSION}/binaries/apache-maven-${M2_VERSION}-bin.tar.gz"
	tar -xvzf /home/solutions/app/apache-maven-${M2_VERSION}-bin.tar.gz -C /home/solutions/app/
	chmod -R 777 $(ls -d /home/solutions/app/apache-maven*/)
	ln -sf $(ls -d /home/solutions/app/apache-maven*/) /home/solutions/app/maven
fi

echo Instalando jenkins ...
if [ ! -f /home/solutions/jenkins/jenkins.war ]; then
	mkdir -p /home/solutions/app/jenkins
	mkdir -p /home/solutions/app/jenkins/ref/init.groovy.d
	cp /home/solutions/init.groovy /home/solutions/app/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy
	curl -fsSL ${JENKINS_URL} -o /home/solutions/app/jenkins/jenkins.war && echo "${JENKINS_SHA}  /home/solutions/app/jenkins/jenkins.war" | sha1sum -c -
	sudo chmod -R 777 /home/solutions/app/jenkins
fi

java $JAVA_OPTS -jar /home/solutions/jenkins/jenkins.war