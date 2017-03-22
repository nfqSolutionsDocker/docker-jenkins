### jenkins

This container has the following characteristics:
- Container nfqsolutions/centos:7.
- Python 3.4
- Nodejs
- Java version 8u92
- Jenkins version 2.7.3
- GNOME Desktop
- Chrome
- ...

For example, docker-compose.yml:
```
jenkins:
 image: nfqsolutions/jenkins
 privileged: true
 restart: always
 container_name: jenkins_test
 net: "host"
 ports:
  - "8081:8800"
 environment:
  - JAVA_OPTS=-Xms512m -Xmx1024m
  - PACKAGES=
  - DISPLAY
 volumes:
  - ./volumen/:/solutions/app
  - /tmp/.X11-unix:/tmp/.X11-unix
  - $HOME/.Xauthority:/root/.Xauthority
 
```


### License

Using this image implies accepting Oracle's [License](http://www.oracle.com/technetwork/java/javase/terms/license/index.html).