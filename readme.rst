=====================
Dockerizing Aerospike
=====================

.. image:: https://git.kozlovskilab.com/kozlovskilab/aerospike/badges/master/build.svg
   :target: https://git.kozlovskilab.com/kozlovskilab/aerospike/commits/master
   :alt: build status
|

:Author: Vladimir Kozlovski
:Contact: vladimir@kozlovskilab.com
:Issues: https://github.com/kozlovskilab/docker-aerospike/issues
:Docker image: https://hub.docker.com/r/kozlovskilab/aerospike/
:Description: Dockerfile to build a Aerospike container image which can be 
              linked to other containers.

:Release notes: http://www.aerospike.com/download/server/notes.html
:Official image: https://hub.docker.com/_/aerospike/
:Official GitHub: https://github.com/aerospike/aerospike-server


.. meta::
   :keywords: Aerospike, Docker, Dockerizing
   :description lang=en: Dockerfile to build a Aerospike container image which 
                         can be linked to other containers.

.. contents:: Table of Contents



Introduction
============

Dockerfile to build a Aerospike container image which can be linked to other 
containers.


Installation
============

Pull the latest version of the image from the docker index. This is the 
recommended method of installation as it is easier to update image in the 
future.
::
    docker pull kozlovskilab/aerospike:latest

Alternately you can build the image yourself.
::
    git clone https://github.com/kozlovskilab/docker-aerospike.git
    cd docker-aerospike
    docker build -t="$USER/aerospike" .


Quick Start
===========
You can run the default `aerospike` command simply:
::
    docker run -d kozlovskilab/aerospike

You can also pass in additional flags to `aerospike`:
::
    docker run -d --name aerospike -p 3000:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 kozlovskilab/aerospike asd --foreground --config-file /opt/aerospike/etc/aerospike.conf

This image comes with a default set of configuration files for `aerospike`, but if you want to provide your own set of configuration files, you can do so via a volume mounted at `/opt/aerospike/etc`:
::
    docker run -d --name aerospike -p 3000:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 -v "$PWD/etc":/opt/aerospike/etc kozlovskilab/aerospike

This image is configured with a volume at `/opt/aerospike/data` to hold the persisted data. Use that path if you would like to keep the data in a mounted volume:
::
    docker run -d --name aerospike -p 3000:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 -v "$PWD/data":/opt/aerospike/data kozlovskilab/aerospike


Upgrading
=========
To upgrade to newer releases, simply follow this 3 step upgrade procedure.

* **Step 1:** Stop the currently running image::

    docker stop aerospike


* **Step 2:** Update the docker image::

    docker pull kozlovskilab/aerospike:latest


* **Step 3:** Start the image::

    docker run -d --name aerospike -p 3000:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 kozlovskilab/aerospike:latest
