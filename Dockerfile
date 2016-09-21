FROM nfqsolutions/maven:3.3.9

MAINTAINER solutions@nfq.com
																   
# Modificaciones para SOLUTIONS
RUN mkdir -p /home/solutions/jenkins
RUN mkdir -p /home/solutions/jenkins.bak
#RUN sudo chmod -R 777 /etc/ssh/ssh_config
#RUN sudo echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config
#RUN sudo chmod -R 777 /etc/
#RUN sudo echo "Europe/Madrid" > /etc/timezone
RUN mkdir -p /home/solutions/jenkins.bak/ref/init.groovy.d
COPY init.groovy /home/solutions/jenkins.bak/ref/init.groovy.d/tcp-slave-agent-port.groovy

# Instalacion de JENKINS
ENV JENKINS_HOME /home/solutions/jenkins
ENV JENKINS_SLAVE_AGENT_PORT 50000
ENV JENKINS_VERSION 2.7.3
ARG JENKINS_SHA=f822e70810e0d30c6fbe7935273635740faa3d89
ARG JENKINS_URL=http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war
ENV JENKINS_UC https://updates.jenkins.io
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log
RUN curl -fsSL ${JENKINS_URL} -o /home/solutions/jenkins.bak/jenkins.war && echo "${JENKINS_SHA}  /home/solutions/jenkins.bak/jenkins.war" | sha1sum -c -

# Script de arranque
COPY jenkins.sh /home/solutions/
RUN sudo chown solutions:nfq /home/solutions/jenkins.sh
RUN sudo chmod 777 /home/solutions/jenkins.sh
RUN sudo chmod a+x /home/solutions/jenkins.sh
RUN sudo sed -i -e 's/\r$//' /home/solutions/jenkins.sh

# Volumen para el JENKINS_HOME
VOLUME /home/solutions/jenkins

# Puertos de salida del jenkins
# - for main web interface:
EXPOSE 8080
# - will be used by attached slave agents:
EXPOSE 50000