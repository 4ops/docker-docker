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
variables:
  DOCKER_TLS_CERTDIR: ""

Build on Docker host:
  stage: build
  image: 4ops/docker
  services:
    - docker:dind
  tags:
    - docker
  before_script:
    - login-gitlab-registry
    - docker --version
  script:
    - docker build -t ${CI_REGISTRY_IMAGE} .
    - push-image ${CI_REGISTRY_IMAGE}
  after_script:
    - docker logout ${CI_REGISTRY}

Build in Kubernetes:
  stage: build
  image: 4ops/docker
  services:
    - docker:dind
  tags:
    - kubernetes
  variables:
    KUBERNETES_PRIVILEGED: "true"
    DOCKER_HOST: tcp://localhost:2375
  before_script:
    - login-gitlab-registry
    - docker --version
  script:
    - docker build -t ${CI_REGISTRY_IMAGE} .
    - push-image ${CI_REGISTRY_IMAGE}
  after_script:
    - docker logout ${CI_REGISTRY}
```
