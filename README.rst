=========
CondaVenv
=========

`virtualenvwrapper <https://bitbucket.org/dhellmann/virtualenvwrapper>`_-like
commands for `conda <http://conda.pydata.org/docs/>`_.

Unlike virtualenvwrapper, conda's environments are not tired to directories, so
you can easily switch between testing environment's without making new copies
of your source code.

Installation
============

Download the script and add it to your .bashrc file.

::

    source /path/to/script/condavenv.sh


Example
=======

Creating (defaults to 'python=2.7 pip')::

    $ mkconda my_env


Creating using specific packages::

    $ mkconda my_other_env python=3.3* pip numpy=1.8


Activating and deactivating::

    $ useconda my_env
    $ unuseconda


Listing::

    $ lsconda
    my_env
    my_other_env


Deleting::

    $ rmconda my_env


Authors
=======

CondaVenv was created by Adam Griffiths (@adamlwgriffiths).


