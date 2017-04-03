FROM python:3.6
MAINTAINER Joshua Russell-Buckland (joshua-russell-buckland.15@ucl.ac.uk)

#RUN mkdir /bcmd

#ADD . /bcmd

# Installing the 'apt-utils' package gets rid of the 'debconf: delaying package configuration, since apt-utils is not installed'
# error message when installing any other package with the apt-get package manager.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-utils \
    ca-certificates \
    curl \
    nano \
    zip \
    gfortran && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install node
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get install nodejs && \
    rm nodesource_setup.sh

RUN git clone https://github.com/buck06191/bcmd-web.git && \
    cd /BCMD && \
    ./configure && \
    make && \
    mkdir working

#set working directory to where bcmd files are
WORKDIR /bcmd-web

EXPOSE 3000
ENV APP_SETTINGS="config.ProductionConfig"
# Install all python/node dependencies
RUN pip install -r requirements.txt && \
    npm install && \
    npm install bower -g && \
    echo '{ "allow_root": true }' > /root/.bowerrc && \
    bower install




CMD ["/bin/bash"]

# TODO dockerignore file
# TODO check directory structure and then mkdir
