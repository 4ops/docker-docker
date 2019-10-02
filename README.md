# Docker image with docker

Simple alpine-based docker image with docker and dockerd.

# Usage

Linux CLI example:

```shell
$ docker run --rm 4ops/docker --version
Docker version 19.03.2, build 6a30dfca03
```

GitLab CI/CD pipeline job example:

```yml
build:
  stage: build
  image: 4ops/docker
  tags:
    - docker
  before_script:
    - login-gitlab-registry
    - docker --version
  after_script:
    - docker logout ${CI_REGISTRY}
  script:
    - docker build -t ${CI_REGISTRY_IMAGE} .
    - docker push ${CI_REGISTRY_IMAGE}
```
