### jenkins

This container has the following characteristics:
- Container nfqsolutions/centos:7.
- Installations yum: wget, git, curl, zip, hg, libaio, epel-release, nodejs, gcc, blas_devel, fftw, fftw-devel, atlas-devel, atlas, 
    atlas-sse3, make, mysql56, mysql56-devel, lapack, lapack-devel, lapack-static, zlib, zlib-devel, openssl, openssl-devel, sqlite-devel, npm
- Installations npm: gulp, gulp-rev-all, gulp-replace, del
- Installation Java: 8u92
- Installation Python: 3.6.1
- Installation Jenkins: 2.67

For example, docker-compose.yml:
```
jenkins:
 image: nfqsolutions/jenkins:2.67-jdk8-python3.6.1
 restart: always
 container_name: jenkins
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