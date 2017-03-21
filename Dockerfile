FROM nfqsolutions/centos:7

MAINTAINER solutions@nfq.com

# Instalacion previa
RUN yum install -y wget git curl zip hg libaio epel-release.noarch && \
	yum -y install python-pip.noarch

# Variables de entorno
ENV JAVA_HOME=/solutions/app/java \
	JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 \
	#M2_HOME=/solutions/app/maven \
	JAVA_VERSION=8u92 \
	#M2_VERSION=3.3.9 \
	JENKINS_HOME=/solutions/app/jenkins \
	JENKINS_SLAVE_AGENT_PORT=50000 \
	JENKINS_VERSION=2.7.3 \
	JENKINS_SHA=f822e70810e0d30c6fbe7935273635740faa3d89 \
	JENKINS_UC=https://updates.jenkins.io
ENV JENKINS_URL=http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war \
	COPY_REFERENCE_FILE_LOG=$JENKINS_HOME/copy_reference_file.log \
	PATH=$PATH:$JAVA_HOME/bin
	#:$M2_HOME/bin
																   
# Modificaciones para SOLUTIONS
COPY init.groovy /solutions/
RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
	mkdir -p /solutions/app/jenkins/ref/init.groovy.d

# Script de arranque
COPY jenkins.sh /solutions/
RUN chmod 777 /solutions/jenkins.sh && \
	chmod a+x /solutions/jenkins.sh && \
	sed -i -e 's/\r$//' /solutions/jenkins.sh

# Volumen para el JENKINS_HOME
VOLUME /solutions/app

# Puertos de salida del jenkins
# - for main web interface:
EXPOSE 8080
# - will be used by attached slave agents:
EXPOSE 50000
EXPOSE 22

# Copy supervisor file
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]