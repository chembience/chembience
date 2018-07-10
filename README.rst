Chembience
=======

.. image:: https://circleci.com/gh/chembience/chembience/tree/master.svg?style=svg
    :target: https://circleci.com/gh/chembience/chembience/tree/master


Overview
--------

**Chembience** is a `Docker <https://docs.docker.com/>`_ based platform intended for the fast development of
`chemoinformatics <https://en.wikipedia.org/wiki/Cheminformatics>`_-centric web applications and microservices.
It supports a clean separation of your scientific web service implementation work from any infrastructure related
configuration requirements. The following schema provides an overview.

.. image:: docs/_images/chembience.png

At its current development stage, Chembience supports three base types of application (*App*) containers: (1) a
`Django <https://www.djangoproject.com/>`_/`Django REST framework <https://www.django-rest-framework.org/>`_-based
*App* container which is specifically suited for the development of web-based `Python <https://www.python.org/>`_
applications, (2) a Python shell-based *App* container which allows for the execution of script-based python
applications, and (3), a `Jupyter <https://www.jupyter.org/>`_-based *App* container which let you run Jupyter
notebooks (currently only a Python kernel is supported).

All *App* container types have pre-configured access to a `Postgres <https://www.postgresql.org/>`_ databases
system running in a separate Docker container (*Database*) on the same Docker virtual network (*Chembience Sphere*).
All containers have the `RDKit <http://www.rdkit.org/>`_  toolkit readily installed (either as Python module or
Postgres extension). Both the Django and the Jupyter *App* containers provide a `Nginx <https://www.nginx.com>`_-based
web server instance running locally at their respective containers (the Django installation is linked by uswgi to its
local Nginx server, while the Jupyter installation is just connecting by a web socket).

Creation and deployment of all Chembience-based containers and services is orchestrated by
`docker-compose <https://docs.docker.com/compose/>`_. Any Docker images required for starting up a Chembience
container are either available from `Docker hub <https://docs.docker.com/docker-hub/>`_
(either as official package releases, third-party images, or pre-built images at the
`Chembience repository <https://hub.docker.com/u/chembience/>`_), or can be build
locally on the user's host machine by running a Docker (docker-compose) build.

If Chembience is started with docker-compose, a Docker virtual network (*Chembience Sphere*) is created on the Docker
host system and all requested *App* containers as well as the *Database* container are brought up. Depending on the
use case of Chembience, a Nginx-based *Proxy* container configured as a reverse proxy can also be added to the virtual
network. The *Proxy* allows for easily spinning up additional *App* containers, or updating and removing existing ones,
while avoiding interference of web traffic to other running Chembience containers and services.

If the Nginx instance of the *Proxy* container discovers an existing or new *App* container inside the *Chembience Sphere*
network which has a Nginx instance running locally to the container, it automatically looks up the (sub) domain
specification of this Nginx instance at the *App* container and makes it available to the outside of the *Chembience
Sphere* network. This might be either any Web-accessible domain or just localhost for locally running applications.

Any of the *Chembience App* containers can be easily added, multiplied, removed or reconfigured. After initialization of
the Chembience base system (see `Quick Start: Base Installation`_ below), any of the *App* directories initially created
during first start-up can be moved, renamed, or copied to create multiple, independent and specialized application
containers, which can be tracked separately as software projects on their own in VCS software like GIT. If further
infrastructure containers are needed for a project (e.g. Solr, elasticsearch, or additional Postgres container
instances), they can be easily added, too.

Current release version of the most important packages are:

* Python 3.6.5
* Django 2.0 + Django Rest Framework 3.8.2
* Postgres 9.6
* RDKit 2018.03.2
* Jupyter 5.5.0
* Postgres 10.4

History
-------

The development of Chembience originally started as a component for the `InChI-Resolver <http://www.inchi-resolver.org/>`_
project (the alpha version of the InChI resolver is currently in the process of being migrated from a predecessor version
of Chembience to the current version provided here).

Releases
--------

- 0.2.1 (June 2018), update to RDKit 2018.03.2, switch to Postgres 10.4
- 0.2.0 (May 2018), switch to RDKit 2018.03, addition of Jupyter *App* container, project clean-up
- 0.1.1 (April 2018), minor bug fixes
- 0.1.0 (March 2018), first beta

Requirements
------------

Please have at least `Docker CE 17.09 <https://docs.docker.com/engine/installation/>`_ and `Docker Compose 1.17 <https://docs.docker.com/compose/install/>`_ installed on your system.


Quick Start: Base Installation
------------------------

Clone the repository::

    git clone https://github.com/chembience/chembience.git chembience

Then, change into the newly created directory ::

    cd chembience/

and start editing the ``.env`` file. At a minimum, both the variables (line 23 and 24) ::

    CHEMBIENCE_UID=1000
    CHEMBIENCE_GID=1000

need to be changed to the UID and GID of the user account you are using for this installation (if you don't know them type ``id`` in your shell).
After this, run the following command (it is important that you do this from inside the ``chembience`` directory) ::

    ./init

As a first step, this will download all necessary Chembience Docker images to your system and may take a while for the
initial setup (approx 3.5GB of downloads from DockerHub). After a successful download, a new directory ``chembient/`` is created
in your home directory ::

    cd ~/chembient

which has the following layout ::

    chembient/django
             /rdkit
             /jupyter
             /share
             /sphere
The first three directories contain the base versions of the Django-, RDKit and Jupyter-based *App* container, respectively. The location
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

For this quick start section, only the most important of these files will be discussed. The command ``./up`` will start up the Django *App*
container, the *Proxy* container and the *Database* container (the initial configuration of the containers is provided in
the ``.env`` file and the ``docker-compose.yml`` file, **NOTE**: the *Proxy* and the Django *App* container connect to
port 80 and 8000 of the host system, respectively, if either or both of these ports are already in use, they can by
reconfigured in ``.env``). If everything went fine, you should now be able to go to ::

    http://localhost        (don't worry, the reverse proxy will report with *503 Service Temporarily Unavailable* there)

and ::

    http://django.localhost    (you should see the welcome page of a bare Django installation, subdomain access using the proxy)
    http://localhost:8000      (alternative direct access to the App container

For the initial setup of Django, still a few steps have to be done. Since Django runs inside a Docker container you can not directly
access Django's ``manage.py`` script to set up things. Instead you have to use the ``django-manage-py`` script provided in the current
directory which passes any arguments to the ``manage.py`` script of the Django instance running inside the Django *App* container.

To finalize the initial setup of Django in your container installation, run these commands (except for using ``django-manage-py``
instead of ``manage.py`` these are the same steps as for any Django installation for setting up Django's admin pages) ::

    ./django-manage-py migrate           (creates the initial Django database tables)
    ./django-manage-py createsuperuser   (will prompt you to create a Django superuser account)
    ./django-manage-py collectstatic     (add's all media (css, js, templates) for the Django admin application; creates a static/ directory in the django directory)

After running these commands you should be able to go to::

    http://django.localhost/admin
    http://localhost:8000/localhost/admin   (alternatively)

and login into the Django admin application with the just set up account and password.

If you want to start the development of own Django apps, go into the ``appsite`` directory. If you already know how to develop
with Django, this should look familiar to you. If not, go to the `official Django tutorial <https://docs.djangoproject.com/en/2.0/intro/tutorial01/>`_
as a starting point (you can jump there to section *Creating the Polls app* because anything before is already done, also any
database setup sections can be skipped). Because the ``appsite`` directory is Docker-bind-mounted into the Django *App* container,
anything you change there is immediately represented inside the container and the web service you are working on (for some changes in ``appsite/appsite`` and settings.py
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

For this quick start section, only the most important of these files will be discussed. The ``./up`` command will start up the database and
the *App* container running just a regular python shell. For connecting to the database, do the following (if you use an unchanged Chembience
configuration, use the shown database connection parameters verbatim, they are not just placeholders):

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
its PYTHONPATH, i.e. if you add a script named script.py to the RDKit *App* directory you can run it like this::

    ./run script.py

The same is true for any python module or package put into the ``~/chembience/share`` directory.


Quick Start: Jupyter App Container
---------------------------------

After the quick start installation of Chembience (see previous section `Quick Start: Base Installation`_), go into directory ::

    cd ~/chembient/jupyter

which has the following layout ::

    .env
    build
    docker-compose.build.yml
    docker-compose.shell.yml
    docker-compose.yml
    docker-entrypoint.sh
    Dockerfile
    down
    jupyter
    jupyter_notebook_config.py
    notebooks
    psql
    requirements.txt
    shell
    up

For this quick start section, only the most important of these files will be discussed. The command ``./up`` will start up the Jupyter *App*
container, the *Proxy* container and the *Database* container (the initial configuration of the containers is provided in
the ``.env`` file and the ``docker-compose.yml`` file, ***NOTE**: the *Proxy* and the Jupyter *App* container connect to
port 80 and 8001 of the host system, respectively, if either or both of these ports are already in use, they can by
reconfigured in ``.env``). If everything went fine, you should now be able to go to ::

    http://localhost        (don't worry, the reverse proxy will report with *503 Service Temporarily Unavailable* there)

and ::

    http://jupyter.localhost    (you should see the login page of Jupyter, subdomain access using the proxy))
    http://localhost:8001       (alternative direct access to the Jupyter container

Login to the Jupyter notebook server with the password ``Jupyter0``. If you know Jupyter, everything should look familiar
to you now. If you are new to Jupyter, you can find the `documentation here <http://jupyter-notebook.readthedocs.io/>`_.
Since Jupyter runs inside a Docker container, its ``jupyter`` command is not accessible directly; instead you have to
use the ``jupyter`` script inside the Juypter *App* directory which will pass all subcommands into the running container::

    ./jupyter [subcommands]

If you want to add and run existing Jupyter notebooks to the Jupyter *App* container, you need to place them in directory::

    ~chembient/jupyter/notebooks

Likewise, if you create new Jupyter notebooks in the Jupyter app and safe them, you will find them at this directory.

In order to bring the whole Chembience stack of Jupyter *App*, *Proxy* and *Database* down again, use the ``down`` script::

    ./down

It will keep anything persistent you have created and stored so far in the database. If you are familiar with ``docker-compose``,
all life-circle commands should work as expected, in fact, ``up`` and  ``down`` are just short cuts for their respective
``docker-compose`` commands.

[... more to come ...]

For any bug reports, comments or suggestion please use the tools here at Github or contact me at my email.

Markus Sitzmann, 2018-05-14
