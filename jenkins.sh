#!/bin/bash

if [ ! -f /home/solutions/jenkins/jenkins.war ]; then
	sudo cp -R /home/solutions/jenkins.bak/* /home/solutions/jenkins
	sudo chown -R solutions:nfq /home/solutions/jenkins
	sudo chmod -R 777 /home/solutions/jenkins
fi

java $JAVA_OPTS -jar /home/solutions/jenkins/jenkins.war