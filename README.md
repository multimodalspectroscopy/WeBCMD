# WeBCMD

*This repository contains the Dockerfile for the BCMD framework described below. All dependencies etc. are downloaded by the file and the required BCMD files are cloned from Github.*

WeBCMD is a web based interface to the BCMD modelling software and framework.

It uses a combination of web development frameworks and Docker to create an easily installable and distributable interface to BCMD.

The only software requirement to install is Docker, which will then handle all other dependencies.

## Docker ##
This version of BCMD uses Docker to wrap and distribute the software for use. This will ensure that on every platform the software is usable and all dependencies are taken care of. In order to use the Docker container, a Dockerfile has been prepared. To build and then use this, you will first need to download and install Docker from [here](https://docs.docker.com/engine/installation/).

Once you have done this, open terminal/Powershell/cmd and navigate to the cloned repository. Then run

```shell
docker build -t WeBCMD:latest .
```
To save data and use data on the computer, you will need to use the 'working' directory with the following command. Any data you wish to use with the models must be stored in the `../host_data` directory. These can be individual files or child directories.
```shell
docker run -it -v /home/user/path/to/host_data:/BCMD/working bcmd-docker
```
