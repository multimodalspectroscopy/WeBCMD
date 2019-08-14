FROM python:3.6.1
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

RUN echo "This Dockerfile was built on Wed 14 Aug 18:37:43 BST 2019." && \
    git clone https://github.com/buck06191/bcmd-web.git && \
    cd /bcmd-web && \
    ./configure && \
    make && \
    mkdir working

#set working directory to where bcmd files are
WORKDIR /bcmd-web
# Expose port for access web interface on local machine

EXPOSE 5000
# Install python requirements
RUN pip install -r requirements.txt && \
    npm install && \
    npm install bower -g && \
    echo '{ "allow_root": true }' > /root/.bowerrc && \
    bower install && \
    make build/BrainSignals.model && \
    make build/rc.model

# Compile BSX
RUN python bparser/bcmd.py -i examples/bsx -d build/ bsx.modeldef &&\
	make build/bsx.model




ENTRYPOINT ["python"]
CMD ["run.py"]
