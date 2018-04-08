Chembience
=======

Overview
--------

**Chembience** is a `Docker <https://docs.docker.com/>`_ based platform intended for the fast development of scientific
web applications and microservices. At its current development stage, Chembience supports two types of base application
containers: (1) a `Python <https://www.python.org/>`_/`Django <https://www.djangoproject.com/>`_/`Django REST framework <https://www.django-rest-framework.org/>`_
-based container type which is specifically suited for the development of web-based applications, and (2) a Python shell-based container type which allows
for the execution of script-based applications. Both base container types have pre-configured access to a Postgres databases
system running in another Docker container. All containers including the database container have the `RDKit <http://www.rdkit.org/>`_  toolkit for building
`chemoinformatics <https://en.wikipedia.org/wiki/Cheminformatics>`_-centric applications readily available (either as
Python module or Postgres extension). The following schema provides an overview about Chembience.


.. image:: docs/_images/chembience.png


On start-up, Chembience creates a Docker virtual network ("Chembience Sphere") on the host system where Docker is running and spins
up the configured application containers which all connect to this network. Currently, this includes the application containers
(optionally "App (1)" and/or "App (2)"), the "Database" container, and a "Proxy" container (Nginx) which acts as a reverse proxy.
The Django installation of the App (1) container is linked to a Nginx web server instance (by uswgi) local to its container.
If the Nginx instance of the reverse proxy container discovers another container inside the Chembience Sphere network with
a locally running Nginx instance, the reverse proxy automatically looks up the (sub) domain specification of the detected Nginx
instance and makes it available to the outside of Chembience Sphere network (which either might be linked to localhost or any
other Web-accessible domain). This mechanism allows for easily bringing up additional App containers or updating or removing existing
ones.

Creation and deployment of all Chembience containers is orchestrated by `docker-compose <https://docs.docker.com/compose/>`_.
All Docker images required for starting up a Chembience container are either available from `Docker hub <https://docs.docker.com/docker-hub/>`_
(either as official package releases, third-party images, or images pre-build by me), or can be build locally on the user's
host machine using Docker (docker-compose) build.

Current release version of the most important packages are:

* Python 3.6.3
* Django 2.0 + Django Rest Framework 3.7.7
* Postgres 9.6
* RDKit 2017.09.3


History
-------

The development of Chembience originally started as a component for the `InChI-Resolver <http://www.inchi-resolver.org/>`_
project (the alpha version of which is currently in the process of being migrated from a predecessor version to the current
version of Chembience).


Requirements
------------

Please have at least `Docker CE 17.09 <https://docs.docker.com/engine/installation/>`_ and `Docker Compose 1.17 <https://docs.docker.com/compose/install/>`_ installed on your system.


Installation (needs update)
-----------------------

Clone this repository::

    https://github.com/markussitzmann/chembience.git chembience

go into directory ::

    cd chembience/

and edit the file ``.env`` to appropriate settings, in particular, variable ``CHEMBIENCE_HOME`` to a file directory location where the user
running the build in the next is allowed to create a directory. If the directory specified in ``CHEMBIENCE_HOME`` does not exist, it will be
created during the first start up of a Docker container. It will be mounted as volume in all containers.

Start the Docker build of the system by going to the ``build``-directory of the ``chembience``-directory and run ``docker-compose build`` (it is
actually important to be in this directory because ``docker-compose`` needs the corresponding ``docker-compose.yml`` configuration file available in the
directory it is run)::

    cd build/
    docker-compose build

This will build all Docker image files needed for Chembience.


Bringing Chembience up
-------------------

go back into the ``chembience`` directory::

    cd ..

and change into the ``bin`` directory and run ``docker-compose up``::

    cd bin/
    docker-compose up

This will bring up all services defined in the file ``docker-compose.yml`` there and keep all database and search index containers running persistently.
APPDOCK will run with the settings provided in ``appdock/.env``. Bringing APPDOCK down is performed by::

    docker-compose down

also in the ``bin`` directory. Any data stored in any databases or search indices will persist and will be available again after restarting the system
with ``docker-compose up`` again.

It is possible to change settings in the ``chembience/.env`` file while the system is down, however, PLEASE NOTE, this may have unwanted side effects.

Some (already working) things
-----------------------------

================
Starting a shell
================

with::

    docker-compose run --rm shell

If this is the first start-up of the shell container, the directory specified in ``APPDOCK_HOME`` will be created and mounted as a Docker volume.
Inside the shell container, this directory is available under ``/home/chembience``.


===============================
Starting a database client psql
===============================

with::

    docker-compose run --rm shell psql -h db -U chembience chembience

Password is the one specified ``CHEMBIENCE_DB_PASSWORD`` in ``.env``.
