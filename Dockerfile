FROM nfqsolutions/centos:7

MAINTAINER solutions@nfq.com

# Instalacion previa
RUN sudo yum install -y wget

# Variables de entorno
ENV JAVA_HOME=/home/solutions/app/java \
	JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 \
	M2_HOME=/home/solutions/app/maven \
	JAVA_VERSION=7u80 \
	M2_VERSION=3.3.9 \
	JENKINS_HOME=/home/solutions/app/jenkins \
	JENKINS_SLAVE_AGENT_PORT=50000 \
	JENKINS_VERSION=2.7.3 \
	JENKINS_SHA=f822e70810e0d30c6fbe7935273635740faa3d89 \
	JENKINS_UC=https://updates.jenkins.io
ENV JENKINS_URL=http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war \
	COPY_REFERENCE_FILE_LOG=$JENKINS_HOME/copy_reference_file.log \
	PATH=$PATH:$JAVA_HOME/bin:$M2_HOME/bin
																   
# Modificaciones para SOLUTIONS
#RUN mkdir -p /home/solutions/app/jenkins
#RUN mkdir -p /home/solutions/jenkins.bak
#RUN sudo chmod -R 777 /etc/ssh/ssh_config
#RUN sudo echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config
#RUN sudo chmod -R 777 /etc/
#RUN sudo echo "Europe/Madrid" > /etc/timezone
#RUN mkdir -p /home/solutions/app/jenkins/ref/init.groovy.d
COPY init.groovy /home/solutions/

# Script de arranque
COPY jenkins.sh /home/solutions/
RUN sudo chown solutions:nfq /home/solutions/jenkins.sh && \
	chmod 777 /home/solutions/jenkins.sh && \
	chmod a+x /home/solutions/jenkins.sh && \
	sed -i -e 's/\r$//' /home/solutions/jenkins.sh

# Volumen para el JENKINS_HOME
VOLUME /home/solutions/app

# Puertos de salida del jenkins
# - for main web interface:
EXPOSE 8080
# - will be used by attached slave agents:
EXPOSE 50000

# Copy supervisor file
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]