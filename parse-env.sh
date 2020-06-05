#!/bin/bash
# Internal script for parsing common.env. Run by other executable scripts

env_dir="${BASH_SOURCE%/*}"
if [[ ! -d "$env_dir" ]]; then env_dir="$PWD"; fi
env_file="$env_dir/common.env"
if [ -f $env_file ]; then
  source $env_file
  export ENV_FILE="$env_file"
fi

export CONTAINER_REGISTRY=${CONTAINER_REGISTRY:-'atsgen'}
export CONTAINER_TAG=${CONTAINER_TAG:-'latest'}

export TUNGSTEN_REPOSITORY=${TUNGSTEN_REPOSITORY:-'http://localhost:6667'}
