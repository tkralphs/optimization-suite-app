This repository contains a small web app that serves as a GUI interface for
editing and loading models into optimization solvers, solving the resulting
models and returning results directly from your web browser without external
services. You can run this app either on your local machine using Docker or
even install it on a remote machine.

It uses the [COIN-OR Optimization
Suite](https://github.com/coin-or/COIN-OR-OptimizationSuite) as the underlying
optimization framework. The web app uses a light-weight webserver (written in
*GO*).

The [original version](https://github.com/PatWie/symphony-web) of this app was
written by [Patrick Wieschollek](http://wieschollek.info/), Thanks, Patrick!

[![screenshot](https://github.com/tkralphs/symphony-web/raw/master/screenshot.png)](#Screenshot)

# Install and Use From Docker Hub

This image is now on [Docker
Hub](https://hub.docker.com/r/tkralphs/optimization-suite-app/). To use,
simply install Docker (see instructions below) and then do

```
docker run -p PORT:9090 tkralphs/optimization-suite
```

The image will automatically be pulled the first time you use it. In Windows and
OS X, you can then fire up the Web browser and point it at either

```
http://***.***.**.**:3333/`
```

where `***.***.**.**` is the IP address of the Docker machine, which you can
retrieve by the command

```
docker-machine ip default
```

In Linux, point your browesr instead at

```
http://localhost:3333/`
```

# Build from Source

## Ubuntu

Just clone the repository and build the docker image by

```
git clone https://github.com/tkralphs/optimization-suite
cd optimization-suite
sudo docker build -t optimization-suite image/
```

To launch the application (listening on Port 9090 inside docker) use

```
sudo docker run -p PORT:9090 optimization-suite
```

which forwards the port 9090 (inside docker) to *PORT* on your machine.
If you use `-p 3333:9090`, then point your browser to `http://localhost:3333/`.

## Windows

First install Docker for Windows. Depending on whether you are using a recent
version of Windows, you may need to enable virtualization in the BIOS
settings. For details, see

https://docs.docker.com/engine/installation/windows

As of this writing, it's important that you let Docker install Git for Windows
(do not uncheck the box for installing git in the installer, even though it
indicates that it is optional). After installing, run the "Docker Quickstart
Terminal" application. Make a note of the IP address assigned to the docker
machine (something like 192.168.99.100).

From the terminal clone the repository and build the docker image by the
commands

```
git clone https://github.com/PatWie/optimization-suite.git
cd optimization-suite
docker build -t optimization-suite image/
```

To launch the application (listening on Port 9090 inside the docker) use

```
docker run -p PORT:9090 optimization-suite
```

which forwards the port 9090 (inside docker) to *PORT* on your machine. If you
use `-p 3333:9090`, then point your browser to `http://***.***.**.**:3333/`,
where `***.***.**.**` is the IP address of the Docker machine, noted earlier.

## Mac OSX

Since Docker is a bit more difficult to get running on OSX than on Linux, this
is some additional documentation for the OSX crowd. OSX is not like
Linux---virtualization is not built into the kernel. Therefore, we need to run
the docker machine inside another VM. For this, we need virtualbox. The
instructions below are for installing virutalbox with `homebrew`, which seems
to work very well. (Caveat: I first found some old instructions on how to do
this and took a round-about path to the installation. Therefore, the list of
commands below is not exactly what I did. However, I think it's the right
incantation if you're starting from scratch with an updated install of
homebrew.)

Update: There now seems to be a trouble-free installation of Docker on OS X as
a native app. I haven't tried this, but I guess it should work well and might
be preferable is you are not already using `homebrew`.

First, install virtualbox

```
brew update
brew tap caskroom/cask
brew cask install virtualbox
```

Now install `docker` and `docker-machine`

```
brew install docker
brew install docker-machine
```

Create a new docker server to run in virtualbox and set environment variables
so docker knows how to connect to it.

```
docker-machine create --driver virtualbox default
eval "$(docker-machine env default)"
```

Now follow instructions as above for building the container

```
git clone https://github.com/tkralphs/optimization-suite.git
cd optimization-suite/
docker build -t optimization-suite image/
```

Finally, start up the server and the container

```
docker-machine start default
docker run -d -p PORT:9090 optimization-suite
```

where `PORT` is the port you want to use for accessing the server on the host
machine (the second port `9090` is the port used by the docker machine running
inside virtual box). Finally, find out what IP address is assigned to the VM
with

```
docker-machine ip default
```

For example, on my OSX box, it is

```
OSX: ~/symphony-web> docker-machine ip default
192.168.99.100
```

Finally, point your browser to the IP address of the VM and the port number from above, i.e.

```
192.168.99.100:PORT
```

If you want to be fancy, you can give the docker VM a name with something like

```
echo $(docker-machine ip default) dockerhost | sudo tee -a /etc/hosts
```

