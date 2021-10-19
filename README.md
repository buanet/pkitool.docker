# pkitool.docker
A spimple Docker image for running PKI Tool.

**WARNING: This Project is still in BETA!**

This Docker image uses [https://github.com/KlausWolfinger/PKIT](https://github.com/KlausWolfinger/PKIT).<br>For more details about this tool please check [https://www.itconsulting-wolfinger.de/](https://www.itconsulting-wolfinger.de/pkit/).

## How to use this image?

### Running from command-line

Simply run the following basic docker run command:

```
docker run -p 4200:4200 --name pkitool -h pkitool buanet/iobroker
```

### Running with docker-compose

When using docker-compose define the pkitool service like this:

```
version: '2'

services:
  pkitool:
    container_name: pkitool
    image: buanet/pkitool
    hostname: pkitool
    ports:
      - "4200:4200"
```

### Persistent data

To make your pkitool data persistent it is recommended to mount a volume or path to `/opt/PKIT`.

On command-line add 
```
-v pkitooldata:/opt/PKIT
```
On docker-compose add
```
    volumes:
      - pkitooldata:/opt/PKIT
```

### Access via browser

The Docker image includes the tool "shellinabox" which opens a webserver which allows you to access a shell in your browser window. 
As it is recommended running the pkitool local (using [docker-ce](https://docs.docker.com/engine/install/) in Linux or [Docker Desktop](https://www.docker.com/products/docker-desktop) in Windows or Mac) you typically can acces the webshell by opening `https://localhost:4200`. 

### Login

When accessing the commandline (by dockerexec or webshell) make sure you login as user `pki`. The default password is `pki`. You can change this by calling `passwd` after login.  

### Running the PKI Tool

Once you are logged in simply type `pki` to access the commandline based user interface. 

## Changelog

### v0.1.0 (2021-10-19)
* project started / initial commit
