#!/bin/bash
set -e

if [ ! -n "$1" ]; then
  echo "Usage: $0 box-name"
  exit $E_BADARGS
fi  

SUPPORTED_BOXES=("centos-6.5" "ubuntu-12.04")

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
OPS_BOX_NAME="opscode-${BOX_NAME}"

if [ ! -d "${HOME}/.vagrant.d/boxes/${OPS_BOX_NAME}" ]; then
  vagrant box add ${OPS_BOX_NAME} http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_${BOX_NAME}_chef-provisionerless.box
fi

# setup working directory
WORK_DIR="prep-box-cookbook-working"
SCRIPT_DIR=`pwd`
cd ../..
if [ ! -d $WORK_DIR ]; then
  mkdir $WORK_DIR
fi 
cd $WORK_DIR
PREP_DIR=`pwd`

# Cleanup existing vendoring
if [ -d "berks-cookbooks" ]; then
  rm -r berks-cookbooks
fi 

# Cleanup previous run
if [ -d "output-virtualbox-ovf" ]; then
  rm -r output-virtualbox-ovf
fi

# vendor
berks vendor -b ${SCRIPT_DIR}/../Berksfile

# pack
packer validate -var "origin_box_name=${OPS_BOX_NAME}" ${SCRIPT_DIR}/${PACK_SCRIPT}
packer build -var "origin_box_name=${OPS_BOX_NAME}" ${SCRIPT_DIR}/${PACK_SCRIPT}

# notify
echo "FINISHED: prepped box is ready at ${PREP_DIR}"
