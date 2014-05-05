=========
CondaVenv
=========

`virtualenvwrapper<https://bitbucket.org/dhellmann/virtualenvwrapper>`_-like
commands for `conda<http://conda.pydata.org/docs/>`_.

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

::

    mkconda my_env

    mkconda my_other_env python=3.3 pip numpy=1.6

    lsconda

    useconda my_env

    unuseconda

    rmconda my_env


Authors
=======

CondaEnv was created by Adam Griffiths (@adamlwgriffiths).


