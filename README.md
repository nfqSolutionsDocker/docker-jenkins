### jenkins

This container has the following characteristics:
- Container nfqsolutions/centos:7.
- Python 3.4
- Nodejs
- Java version 8u92
- Jenkins version 2.7.3

For example, docker-compose.yml:
```
jenkins:
 image: nfqsolutions/jenkins
 restart: always
 container_name: jenkins_test
 ports:
  - "8081:8080"
 environment:
  - JAVA_OPTS=-Xms512m -Xmx1024m
  - PACKAGES=
 volumes:
  - ./volumen/:/solutions/app
 
```


### License

Using this image implies accepting Oracle's [License](http://www.oracle.com/technetwork/java/javase/terms/license/index.html).