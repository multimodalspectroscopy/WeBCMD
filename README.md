# WeBCMD  [![DOI](https://zenodo.org/badge/87054535.svg)](https://zenodo.org/badge/latestdoi/87054535)



*This repository contains the Dockerfile for the BCMD framework described below. All dependencies etc. are downloaded by the file and the required BCMD files are cloned from Github.*

WeBCMD is a web based interface to the BCMD modelling software and framework.

It uses a combination of web development frameworks and Docker to create an easily installable and distributable interface to BCMD.
___
Installation
------------
The only software requirement to install is Docker, which will then handle all other dependencies.
### Docker ###
This version of BCMD uses Docker to wrap and distribute the software for use. This will ensure that on every platform the software is usable and all dependencies are taken care of. In order to use the Docker container, a Dockerfile has been prepared. To build and then use this, you will first need to download and install Docker from [here](https://docs.docker.com/engine/installation/).

*Note: If you are using Linux, you will need to install Docker Compose separately, details of which can be found [here](https://docs.docker.com/engine/installation/linux/ubuntu/). If you are using Docker for Windows or Docker for Mac, this has already been installed.*

Once you have done this, open terminal/Powershell/cmd and navigate to the cloned repository. Then run

```shell
docker-compose up
```
This will then install the dependencies and load all required environment variables.
It may be necessary or useful to rebuild the Docker containers from scratch, such as if notified of a new version. In order to this simply run the following:
```shell
docker-compose build --force-rm --no-cache
```
This will ensure that only the most recent version of WeBCMd is built.

#### Other Uses ####
There are some uses which have not yet been fully implemented within the graphical interface, and existing users of the software
may wish to access these. Whilst the use cases themselves will not be explored in detail within this paper, this functionality can still
be accessed inside the Docker container by using the command line.
To build and launch the container to do this a slightly different process is required.
1. **Build** The container needs to be built before running, and the following command needs to be run from inside the directory
with the Dockerfile in and ensures that the most recent version of each intermediate container is used:
```shell
docker build --no-cache --rm -t webcmd:latest .
```
2. **Running** When using the command line interface, if you want access and store data on the host computer, you will need to
use the ’working’ directory with the following command. Any data you wish to use with the models must be stored in the
host_data directory. These can be individual files or child directories.
```shell
docker run -it -v /home/user/path/to/host_data:/BCMD/working --entrypoint /bin/bash webcmd
```
___
Usage
------

By default, the web interface will be accessible at http://localhost:5000 in your web browser.

### Before Running Models ###
Before being able to run the models they will first need to be compiled and built.

This is done by navigating to the Admin panel at the top of the screen and entering the following user details:
<div style="text-align:center">**Username:** LOCAL_USER<br>**Password:** LOCAL_PASSWORD</div>
This will bring you to the WeBCMD-Admin page.

Begin by compiling the required models in the appropriate tab before then uploading their information to the local MongoDB container.

Return to the homepage where you can then view model information, run a Steady State Autoregulation simulation and run normal model simulations.

### Steady State Simulations ###
The BrainSignals models can be run in a steady state simulation to compare their autoregulation response. Minimum and maximum values for the input variable being considered are predefined, and there are three choices of model run:
1. up: Min -> Max
2. down: Max -> Min
3. both: Min -> Max -> Min

The default BrainSignals response curve is plotted for comparison.

### Running Models ###
Running models is hopefully an intuitive process. It consists of approximately 7 steps, not all of which will be required.

1. **Select Model** You must first select one of the compiled models you wish to run.
2. **Upload Data** If your models requires input data, you can upload that at this step as a CSV file. You must also select which columns are inputs and which are outputs. For the purposes of this model, if it is prsent, time is treated as an input and is expected to be given the variable name 't'.
3. **Generate Time Data** If time points were not uploaded as part of your data, it is possible to generate evenly spaced time points at this step. *Note: Time is the only variable required for every model. It is important that some form of time data is provided or generated before running the model.*
4. **Generate a Demand Signal** In the case of BrainSignals models, it may be useful or necessary to simulate a demand input. A number of predefined peak types can be used to generate Demand signal here.
5. **Parameters** If you wish to vary any parameters from the default values, you can do so at this step. *Note: If you choose to run the model on the 'Default' setting, any changes made here will be ignored. To include parameter changes, please run your model on the 'Custom' setting.*
6. **Model Review** At this step you can review your model choices, select data for each input/output and run the model. There are two model run types:
    1. **Default** This will run the model using the supplied data and time values, but will use default parameters and default inputs/outputs, details of which are displayed inthe "View Model Information" tab.
    2. **Custom** If you wish to run the model using non-default parameters, and choose cusotm inputs and outputs, you can do so in this setting. Selecting include on an Output will include it in the model run data that is returned. It is also possible to select a 'Burn In Time' in this mode, which may be useful if you want to run the model for a time before collecting data. This may be useful if you wish to wait for initial transient behaviour to disappear.
7. **Model Display** In this final step you can preview your generated model data and download it as a CSV file for use in other programs.
