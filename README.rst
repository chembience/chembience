Chembience
=======

Overview
--------

**Chembience** is a `Docker <https://docs.docker.com/>`_ based platform intended for the fast development of
`chemoinformatics <https://en.wikipedia.org/wiki/Cheminformatics>`_-centric web applications and microservices.
The following schema provides an overview about Chembience.

.. image:: docs/_images/chembience.png

At its current development stage, Chembience supports two base types of application (*App*) containers: (1) a
`Django <https://www.djangoproject.com/>`_/`Django REST framework <https://www.django-rest-framework.org/>`_-based
App container which is specifically suited for the development of web-based `Python <https://www.python.org/>`_/ applications,
and (2) a Python shell-based App container which allows for the execution of script-based python applications.
Both App container types have pre-configured access to a `Postgres <https://www.postgresql.org/>`_ databases
system running in a separate Docker container (*Database*) on the same Docker virtual network (*Chembience Sphere*).
All *App* containers and the *Database* container have the `RDKit <http://www.rdkit.org/>`_  toolkit
readily installed (either as Python module or Postgres extension). The Django-based *App* container also provides a
`Nginx <https://www.nginx.com>`_-based web server instance running locally at the same the container, linking the
Django installation by uswgi to Nginx.

Creation and deployment of all Chembience-based containers and services is orchestrated by `docker-compose <https://docs.docker.com/compose/>`_.
Any Docker images required for starting up a Chembience container are either available from `Docker hub <https://docs.docker.com/docker-hub/>`_
(either as official package releases, third-party images, or images pre-build by me), or can be build locally on the user's
host machine by running a Docker (docker-compose) build.

When Chembience is brought up with docker-compose, a Docker virtual network (*Chembience Sphere*) is created on the Docker host
system and and the *App* containers as well as the *Database* container are started. Depending on the use case of Chembience,
a `Nginx <https://www.nginx.com>`_-based *Proxy* container configured as a reverse proxy can also be added to the virtual network.
The *Proxy* allows for easily bringing up additional *App* containers, or updating and removing existing ones, while
avoiding interference of web traffic to other Chembience containers and services.
If the Nginx instance of the *Proxy* container discovers an existing or new *App* container inside the *Chembience Sphere*
network having a locally running Nginx instance, it automatically looks up the (sub) domain specification of the detected
Nginx instance at the *App* container and makes it available to the outside of the *Chembience Sphere* network.
This might be either any Web-accessible domain or just localhost for locally running applications.

Any of the *Chembience App* containers can be easily added, multiplied, removed or reconfigured. After initialization of
the Chembience base system (see `Quick Start: Base Installation`_ below), any of the *App* directories initially created during first start-up can be moved, renamed,
or copied to create multiple, independent application containers, each of which can be tracked separately by version control
systems like Git. If further infrastructure containers are needed for a project (e.g. Solr, elasticsearch, or additional
Postgres container instances), they can be easily added, too.

Current release version of the most important packages are:

* Python 3.6.3
* Django 2.0 + Django Rest Framework 3.7.7
* Postgres 9.6
* RDKit 2017.09.3 (sorry, no 2018.03 yet)


History
-------

The development of Chembience originally started as a component for the `InChI-Resolver <http://www.inchi-resolver.org/>`_
project (the alpha version of the InChI resolver is currently in the process of being migrated from a predecessor version
of Chembience to the current version provided here).

Releases
--------

April, 2018     0.1.0 (first beta)


Requirements
------------

Please have at least `Docker CE 17.09 <https://docs.docker.com/engine/installation/>`_ and `Docker Compose 1.17 <https://docs.docker.com/compose/install/>`_ installed on your system.


Quick Start: Base Installation
------------------------

Clone the repository::

    git clone https://github.com/chembience/chembience.git chembience

Then, change into the newly created directory ::

    cd chembience/

and run (it is important that you do this from inside the chembience directory) ::

    ./init

As a first step, this will download all necessary Chembience Docker images to your system and may take a while for the
initial setup (approx 3.5GB of downloads from DockerHub). After a successful download, a new directory ``chembient/`` is created
in your home directory ::

    cd ~/chembient

which has the following layout ::

    chembient/django
             /rdkit
             /share
             /sphere
The first two directories contain the base versions of the Django- and RDKit-based *App* container, respectively. The location
and name of these base application directories is freely configurable (in fact, it isn't even required to keep them in the
``chembient`` parent directory). The ``share/`` directory can be used to store resources and (python) packages that should
be common to all *App* containers. The ``sphere/`` directory holds scripts and files related to all core infrastructure
containers (e.g. the *Database* and *Proxy* containers).

Quick Start: Django App Container
---------------------------------

After the quick start installation of Chembience (see previous section `Quick Start: Base Installation`_), go into directory ::

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

For this quick start section, only some of these files will be discussed. The command ``./up`` will start up the Django *App*
container, the *Proxy* container and the *Database* container (the initial configuration of the containers is provided in
the ``.env`` file and the ``docker-compose.yml`` file, **PLEASE NOTICE**: the *Proxy* container connects to port 80 of the
host system, if this port is already in use, it can by reconfigured in ``.env``). If everything went fine, you should
now be able to go to ::

    http://localhost        (don't worry, the reverse proxy will report with *503 Service Temporarily Unavailable* there)

and ::

    http://app.localhost    (you should see the welcome page of a bare Django installation)

For the initial setup of Django, still a few steps have to be done. Since Django runs inside a Docker container you can not directly
use Django's ``manage.py`` script to set up things. Instead you have to use the ``django-manage-py`` script provided here which passes
any arguments to the ``manage.py`` script of the Django instance running inside the Django *App* container.

To finalize the initial setup of Django in your container installation, run these commands (except for using ``django-manage-py``
instead of ``manage.py`` these are the same steps as for any Django installation for setting up Django's admin pages) ::

    ./django-manage-py migrate           (creates the initial Django database tables)
    ./django-manage-py createsuperuser   (will prompt you to create a Django superuser account)
    ./django-manage-py collectstatic     (add's all media (css, js, templates) for the Django admin application; creates a static/ directory in the django directory)

After running these commands you should be able to go to::

    http://app.localhost/admin

and login into the Django admin application with the just set up account and password.

If you want to start the implementation of own Django apps, go into the ``appsite`` directory. If you already know how to develop
with Django, this should look familiar to you. If not, go to the `official Django tutorial <https://docs.djangoproject.com/en/2.0/intro/tutorial01/>`_
as a starting point (you can jump there to section *Creating the Polls app* because anything before is already done, also any
database setup sections can be skipped). Because the ``appsite`` directory is Docker-bind-mounted into the Django *App* container,
anything you change there is immediately represented inside the container and the web service you implement (for some changes in ``appsite/appsite`` and settings.py
a container restart might be necessary).

In order to bring the whole Chembience stack of Django *App*, *Proxy* and *Database* down again, use the ``down`` script::

    ./down

It will keep anything persistent you have created and stored so far in the database. If you are familiar with ``docker-compose``,
all life-circle commands should work as expected, in fact, ``up`` and  ``down`` are just short cuts for their respective
``docker-compose`` commands.


Quick Start: RDKit App Container
--------------------------------

After the quick start installation of Chembience (see section `Quick Start: Base Installation`_), go into directory ::

    cd ~/chembient/rdkit

You will see the following layout::

   build
   context
   docker-compose.build.yml
   docker-compose.shell.yml
   docker-compose.yml
   docker-entrypoint.sh
   Dockerfile
   psql
   requirements.txt
   run
   up

For this quick start section, only some of these files will be discussed. The ``./up`` command will start up the database and
the *App* container running just a regular python shell. For connecting to the database, do this (if you use an unchanged Chembience
configuration, use the database connection parameters as shown, they are no placeholders):

.. code-block:: python

    import psycopg2
    import pprint

    conn_string = "host='db' dbname='chembience' user='chembience' password='Arg0'"
    conn = psycopg2.connect(conn_string)
    cursor = conn.cursor()

    # rdkit extension installed?
    cursor.execute("select * from pg_extension")
    extensions = cursor.fetchall()
    pprint.pprint(extensions)

If you use the ``./run`` command, it does the same without starting an interactive shell, however it will pass any command line arguments
to the Python interpreter of the *App* container. The Python interpreter has the current directory (``~/chembience/rdkit``) available on
its PYTHONPATH, i.e. if you add a script named script.py to the directory you can run it like this::

    ./run script.py

The same is true for any python module or package put into the ``~/chembience/share`` directory.


[ ... more to come ...]

Markus Sitzmann, 2018-04-23
