*BASE* development environment

# Prerequistes

    $ git -v
    $ docker -v
    $ docker-compose

# Setup

    $ git clone git@github.com:bitclave/base-development.git && cd base-development
    $ git submodule init && git submodule update

# How to run?

1. To build spring boot jars and then docker images

```
    $ ./build.sh #this automatically starts all services
```

1. To start base platform and services

```
    $ ./start.sh #use this to start services without rebuilding
```

2. Its time to run engineering example


# How to stop?

    $ ./cleanup.sh

# How to run tests?
    
    $ npm install
    $ npm test
