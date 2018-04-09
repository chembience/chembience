Chembience
=======

Overview
--------

**Chembience** is a `Docker <https://docs.docker.com/>`_ based platform intended for the fast development of
`chemoinformatics <https://en.wikipedia.org/wiki/Cheminformatics>`_-centric web applications and microservices.
At its current development stage, Chembience supports two types of base application containers: (1) a
`Python <https://www.python.org/>`_/`Django <https://www.djangoproject.com/>`_/`Django REST framework <https://www.django-rest-framework.org/>`_
-based container type which is specifically suited for the development of web-based applications, and (2) a Python shell-based container type which allows
for the execution of script-based python applications. Both base container types have pre-configured access to a `Postgres <https://www.postgresql.org/>`_ databases
system running in a separate Docker container. All *App* containers and the database container have the `RDKit <http://www.rdkit.org/>`_  toolkit
readily available (either as Python module or Postgres extension). The following schema provides an overview about Chembience.


.. image:: docs/_images/chembience.png


Chembience creates a Docker virtual network (*Chembience Sphere*) on the host system where Docker is running and spins
up the configured application containers which all are linked by this network. Currently, this includes the application containers
(*App (1)/Django* and/or *App (2)/RDKit*), the *Database* container, and a *Proxy* container (Nginx) which acts as a reverse proxy.
The Django installation of the *App (1)* container is linked (by uswgi) to a Nginx web server instance running locally at the same container.
If the Nginx instance of the *Proxy* container discovers another container inside the *Chembience Sphere* network with such
a Nginx instance running, the *Proxy* automatically looks up the (sub) domain specification of the detected Nginx
instance and makes it available to the outside of *Chembience Sphere* network (which either might be linked to localhost or any
other Web-accessible domain). This mechanism allows for easily bringing up additional *App* containers or updating or removing existing
ones.

Creation and deployment of all Chembience containers is orchestrated by `docker-compose <https://docs.docker.com/compose/>`_.
Any Docker images required for starting up a Chembience container are either available from `Docker hub <https://docs.docker.com/docker-hub/>`_
(either as official package releases, third-party images, or images pre-build by me), or can be build locally on the user's
host machine by running a Docker (docker-compose) build.

All *Chembience App* containers can be easily added, multiplied, removed or reconfigured. After initialization of
the Chembience base system (see below), the initially created *App* directories can be moved, renamed, or copied to create multiple,
independent application containers, each of which can be tracked on its own in a Git or other VCS repository. If further
infrastructure containers are needed for a project (e.g. Solr, elasticsearch, ...), they can be easily added, too.

Current release version of the most important packages are:

* Python 3.6.3
* Django 2.0 + Django Rest Framework 3.7.7
* Postgres 9.6
* RDKit 2017.09.3


History
-------

The development of Chembience originally started as a component for the `InChI-Resolver <http://www.inchi-resolver.org/>`_
project (the alpha version of the InChI resolver is currently in the process of being migrated from a predecessor version
of Chembience to the current version provided here).

Releases
--------

April, 2018     0.1.0 (Early beta)


Requirements
------------

Please have at least `Docker CE 17.09 <https://docs.docker.com/engine/installation/>`_ and `Docker Compose 1.17 <https://docs.docker.com/compose/install/>`_ installed on your system.


Quick Start Installation
------------------------

Clone the repository::

    https://github.com/chembience/chembience.git chembience

and change into the newly created directory ::

    cd chembience/

and run (it is important that you do this from inside the chembience directory) ::

    ./init

As a first step, this will download all necessary Chembience Docker images to your system and may take a while for the
initial setup (approx 3.5GB of downloads from DockerHub). After a successful download, a new directory ``chembient/`` is created
in your home directory ::

    cd ~/chembient

which has four subdirectories ::

    chembient/django
             /rdkit
             /share
             /sphere
The first two directories contain the base versions of the Django and the RDKit *App*, respectively. The location
and name of these base application directories is freely configurable (in fact, it isn't even required to keep them in the
``chembient`` parent directory). The ``share/`` directory can be used to store resources and (python) packages that should
be common to all containers. The ``sphere/`` directory holds scripts and files related to all core infrastructure
containers (e.g. the *Database* and *Proxy* containers).

Django App Quick Start
----------------------

After the quick start installation of Chembience (see previous section), go into ::

    cd ~/chembient/django

which has the following layout ::

    .env
    appsite
    build
    django-manage-py
    docker-compose.build.yml
    docker-compose.shell.yml
    docker-compose.yml
    docker-entrypoint.sh
    Dockerfile
    down
    psql
    requirements.txt
    shell
    up
    uswgi-log

For the quick start section, only some of these files will be discussed. The command ``./up`` will start up the Django *App*
container, the *Proxy* container and the *Database* container (the initial configuration of the containers is provided in
the ``.env`` file and the ``docker-compose.yml`` file, **PLEASE NOTICE**: the *Proxy* container connects to port 80 of the
host system, if this port is already in use, it can by reconfigured in ``.env``). If everything went fine you should
now be able to go to ::

    http://localhost        (don't worry, the reverse proxy will report with *503 Service Temporarily Unavailable* there

and ::

    http://app.localhost    (you should see the welcome page of a bare Django installation)

For the initial setup of Django, still a few steps have to be done. Since Django runs inside a Docker container you can not directly
use Django's ``manage.py`` script to set up things. Instead you have to use the ``django-manage-py`` script provided here which passes
any arguments to the ``manage.py`` script and the Django instance running inside the container.

To finalize the initial setup of Django in your container installation, run these commands (except for using ``django-manage-py``
instead of ``manage.py`` these are the same for any Django installation if you want to install Django's admin app) ::

    ./django-manage-py migrate           (creates the initial Django database tables)
    ./django-manage-py createsuperuser   (will prompt you to create a Django superuser account)
    ./django-manage-py collectstatic     (add's all media (css, js, templates) for the Django admin application; creates a static/ directory in the Django directory)

After running these commands you should be able to go to::

    http://app.localhost/admin

and login into the Django admin application with the just set up account and password.

If you want to start the implementation of own Django apps, go to the ``appsite`` directory. If you already know how to develop
with Django, this should look familiar to you. If not, go to the `official Django tutorial <https://docs.djangoproject.com/en/2.0/intro/tutorial01/>`_
as a starting point (you can jump there to section *Creating the Polls app* because anything before is already done, also any
database setup sections can be skipped). Because the ``appsite`` directory is bind mounted into the Django *App* container,
anything you do there is immediately represented inside the container (for some changes in ``appsite/appsite`` and settings.py
a container restart might be necessary).

In order to bring the whole Chembience stack of Django *App*, *Proxy* and *Database* down again, use the ``down`` script::

    ./down

It will keep anything persistent you have created and stored in the database. If you are familiar with ``docker-compose``,
all life-circle commands should work as expected.
