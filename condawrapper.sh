#!/bin/bash

# debugging
#set -xv

# if we set this, we can't return anything but 0 from our functions
# or it will consider it an error and quit
# good fucking job dickheads
#set -e

# success is 1, because fuck the bash police
SUCCESS=1
FAILURE=0

# https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
function confirm()
{
    msg=${@:-"Are you sure?"}
    read -p "$msg [y/n]" -n 1 -r
    echo
    retval=$FAILURE
    if [[ $REPLY =~ ^[Yy]$ ]] ; then
        retval=$SUCCESS
    fi
    return $retval
}

# https://stackoverflow.com/questions/284662/how-do-you-normalize-a-file-path-in-bash
function resolve_dir()
{
    # return the normalized path name to ensure deletion works!
    abspath=$(cd "${path%/*}" && echo "$PWD/${path##*/}")
    echo $abspath
}

function condaenvs()
{
    dir=`conda info | grep 'envs directories' | awk '{ print $4 }'`
    echo $dir
}

function mkconda()
{
    # check for bad arguments or help
    min_args=1
    if [ $# -lt $min_args ] || [[ $1 =~ ^(-h|--help)$ ]] ; then
        echo -e "usage: mkconda [-h] name [packages] [conda args]"
        echo
        echo -e "Creates a new conda environment using the 'conda create' command."
        echo
        echo -e "positional arguments:"
        echo -e "\tname\tThe environment to create."
        echo -e "\tname\tThe base packages to use, defaults to 'python pip'."
        echo
        echo -e "optional arguments:"
        echo -e "\t-h, --help\tshow this help message and exit"
        echo -e "\tconda args\targuments to pass to conda's create command (see http://conda.pydata.org/docs/commands/create.html)"
        return 1
    fi
    name="$1"
    shift
    packages=
    if [ $# -eq 0 ] ; then
        packages="python pip"
    fi
    conda create -n $name $packages $*
}

function cpconda()
{
    # check for bad arguments or help
    min_args=2
    if [ $# -lt $min_args ] || [[ $1 =~ ^(-h|--help)$ ]] ; then
        echo -e "usage: cpconda [-h] source name [conda args]"
        echo
        echo -e "Copies an existing conda environment using the 'conda clone' command."
        echo
        echo -e "positional arguments:"
        echo -e "\tsource\tThe environment to copy."
        echo -e "\tname\tThe environment to create."
        echo
        echo -e "optional arguments:"
        echo -e "\t-h, --help\tshow this help message and exit"
        echo -e "\tconda args\targuments to pass to conda's create command (see http://conda.pydata.org/docs/commands/create.html)"
        return 1
    fi
    orig="$1"
    shift
    new="$1"
    shift
    conda create --clone "$orig" -n "$new" $*
}

function useconda()
{
    # check for bad arguments or help
    min_args=1
    if [ $# -lt $min_args ] || [[ $1 =~ ^(-h|--help)$ ]] ; then
        echo -e "usage: useconda [-h] name"
        echo
        echo -e "Activates an existing conda environment."
        echo
        echo -e "positional arguments:"
        echo -e "\tname\tThe environment to make active."
        echo
        echo -e "optional arguments:"
        echo -e "\t-h, --help\tshow this help message and exit"
        return 1
    fi
    name=$1
    shift
    source activate $name
}

function unuseconda()
{
    # check for bad arguments or help
    min_args=0
    if [ $# -lt $min_args ] || [[ $1 =~ ^(-h|--help)$ ]] ; then
        echo -e "usage: unuseconda [-h]"
        echo
        echo -e "Deactivates an active conda environment."
        echo
        echo -e "positional arguments:"
        echo -e "\tname\tThe environment to make active."
        echo
        echo -e "optional arguments:"
        echo -e "\t-h, --help\tshow this help message and exit"
        return 1
    fi
    source deactivate
}

function lsconda()
{
    # check for bad arguments or help
    min_args=0
    if [ $# -lt $min_args ] || [[ $1 =~ ^(-h|--help)$ ]] ; then
        echo -e "usage: lsconda [-h]"
        echo
        echo -e "Prints a list of available conda environments."
        echo
        echo -e "optional arguments:"
        echo -e "\t-h, --help\tshow this help message and exit"
        return 1
    fi
    # envs directories : /<home dir>/anaconda/envs
    conda info --envs
}

function rmconda()
{
    # check for bad arguments or help
    min_args=1
    if [ $# -lt $min_args ] || [[ $1 =~ ^(-h|--help)$ ]] ; then
        echo -e "usage: rmconda [-h] env"
        echo
        echo -e "Deletes a conda environment."
        echo
        echo -e "optional arguments:"
        echo -e "\t-h, --help\tshow this help message and exit"
        return 1
    fi
    name="$1"
    shift

    conda remove --name $name --all
}

export mkconda
export cpconda
export useconda
export lsconda
export rmconda
