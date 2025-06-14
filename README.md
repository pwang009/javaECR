# java 8 docker ECR test

## steps

### create docker image and test locally
```sh
# mvn clean package
docker build -t hello-world-api .
docker run -d -p 8080:8080 hello-world-api
curl http://localhost:8080/hello
```

### check java version without starting container
```sh
docker run --rm hello-world-api java -version
docker run --rm hello-world-api cat /etc/os-release
```

### remove local images
```sh
docker system prune -af
```

