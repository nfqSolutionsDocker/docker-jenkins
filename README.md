### jenkins

This container has the following characteristics:
- Container nfqsolutions/centos:7.
- The java directory is /solutions/app/java.
- The maven directory is /solutions/app/maven.
- Installations script of jenkins in centos. This script copy jenkins directory to volumen. This script is executing in the next containers or in the docker compose.

For example, docker-compose.yml:
```
app:
 image: nfqsolutions/jenkins:2.7.3-jdk7-mvn3.3.9
 restart: always
 ports:
  - "8080:8080"
 environment:
  - PACKAGES=
  - JAVA_OPTS=-Xms124m -Xmx1024m
 volumes:
  - <mydirectory>:/solutions/app
 
```