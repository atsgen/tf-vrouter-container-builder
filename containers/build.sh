#!/bin/bash

my_file="$(readlink -e "$0")"
my_dir="$(dirname $my_file)"
source "$my_dir/../parse-env.sh"

function update_file() {
  local file=$1
  local new_content=$2
  local content_encoded=${3:-'false'}
  local file_md5=${file}.md5
  if [[ -f "$file" && -f "$file_md5" ]] ; then
    local new_md5
    if [[ "$content_encoded" == 'true' ]] ; then
      new_md5=`echo "$new_content" | base64 --decode | md5sum | awk '{print($1)}'`
    else
      new_md5=`echo "$new_content" | md5sum | awk '{print($1)}'`
    fi
    local old_md5=`cat "$file_md5" | awk '{print($1)}'`
    if [[ "$old_md5" == "$new_md5" ]] ; then
      return
    fi
  fi
  if [[ "$content_encoded" == 'true' ]] ; then
    echo "$new_content" | base64 --decode > "$file"
  else
    echo "$new_content" > "$file"
  fi
  md5sum "$file" > "$file_md5"
}

for rfile in $(ls $my_dir/../*.repo.template) ; do
  content=$(cat "$rfile" | sed -e "s|\${TUNGSTEN_REPOSITORY}|${TUNGSTEN_REPOSITORY}|g")
  dfile=$(basename $rfile | sed 's/.template//')
  update_file "tungsten-vrouter-kernel-build-init/$dfile" "$content"
done

docker build -t $CONTAINER_REGISTRY/tungsten-vrouter-kernel-build-init:$CONTAINER_TAG --network host tungsten-vrouter-kernel-build-init

