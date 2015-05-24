#!/bin/bash
set -e

if [ ! -n "$1" ]; then
  echo "Usage: $0 box-name"
  exit $E_BADARGS
fi  

SUPPORTED_BOXES=("centos-6.5")

for box in ${SUPPORTED_BOXES[@]}; do
  if [[ $box =~ $1 ]]; then
    BOX_NAME=$box
    break
  fi
done

if [[ ! $BOX_NAME ]]; then
  echo "Unsupported box $1"
  echo "Supported Boxes: ${SUPPORTED_BOXES[@]}"
  exit $E_BADARGS
fi

PACK_SCRIPT="repack_${BOX_NAME%-*}.json"

if [ ! -d "$HOME/.vagrant.d/boxes/opscode-$BOX_NAME" ]; then
  vagrant box add opscode-centos-6.5 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_${BOX_NAME}_chef-provisionerless.box
fi

rm -fr berks-cookbooks
berks vendor -b ../Berksfile

packer validate -var "origin_box_name=opscode-${BOX_NAME}" ${PACK_SCRIPT}
packer build -var "origin_box_name=opscode-${BOX_NAME}" ${PACK_SCRIPT}
