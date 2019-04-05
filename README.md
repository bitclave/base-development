*BASE* development environment

# Prerequistes

    $ git -v
    $ docker -v
    $ docker-compose
     configurate limit of memory to 4096mb for docker engine (docker->settings->advanced)
     
# Setup

    $ git clone git@github.com:bitclave/base-development.git && cd base-development
    $ git submodule init && git submodule update

# Services and ports (global->docker). docker container ls (after run build.sh)
```
shepherd:           0.0.0.0:5007->4201/tcp                             
auth-frontend:      0.0.0.0:5005->4200/tcp
rt-search:          0.0.0.0:5001->5001/tcp
matcher:            ---
auth-sdk:           0.0.0.0:5003-5004->5003-5004/tcp
shepherd-backend:   0.0.0.0:5006->5006/tcp
base-node:          0.0.0.0:8080->8080/tcp
geth:               0.0.0.0:8545->8545/tcp
nodedb(postgres):   0.0.0.0:5435->5432/tcp, 0.0.0.0:54321->54322/tcp
mongodb:            0.0.0.0:27017->27017/tcp
elasticsearch:      0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp
```

# Useful commands:
```
docker stats --all
docker image ls
docker container ls
docker build . -t CONTAINER_NAME (in dir with Dockerfile)
docker logs -t -f CONTAINER_NAME
docker-compose -f ./config/SOME_DOCKER_COMPOSE_FILE.yml up -d
docker-compose -f ./config/SOME_DOCKER_COMPOSE_FILE.yml down
```

# How to run?

1. To build spring boot jars and then docker images

```
    $ ./build.sh #this automatically starts all services
```

2. To start base platform and services

```
    $ ./start.sh #use this to start services without rebuilding
```

# How to stop?

    $ ./cleanup.sh

# How to run tests?
    
    $ npm install
    $ npm test
