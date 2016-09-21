### jenkins

This container has the following characteristics:
- Container nfqsolutions/java:7-jdk.
- The java directory is /usr/local/java.
- The maven directory is /usr/local/maven.
- Installations script of jenkins in centos. This script copy jenkins directory to volumen. This script is executing in the next containers or in the docker compose.

For example, docker-compose.yml:
```
app:
 image: nfqsolutions/jenkins:2.7.3
 restart: always
 ports:
  - "8080:8080"
 environment:
  - PACKAGES=
  - JAVA_OPTS="-Xms124m -Xmx1024m"
 command: /bin/bash -c "/home/solutions/install_packages.sh && /home/solutions/jenkins.sh"
 volumes:
  - <mydirectory>:/usr/local/jenkins
 
```