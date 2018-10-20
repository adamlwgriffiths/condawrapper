#!/bin/bash

# debugging
#set -xv
#set -e

function mkconda() {
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
    packages="python pip"
    conda create -n $name $packages $*
}

function rmconda() {
    conda remove --name $* --all
}

function lsconda() {
    conda info --envs $*
}

function cpconda() {
    orig="$1"
    shift
    conda create --clone "$orig" -n $*
}

function useconda() {
    source activate $*
}

function unuseconda() {
    source deactivate $*
}

export mkconda
export cpconda
export useconda
export lsconda
export rmconda
