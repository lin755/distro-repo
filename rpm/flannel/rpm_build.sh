#!/bin/bash

echo "Not necessary to implement it"
exit 0

CUR_DIR=$(cd `dirname $0`; pwd)

#sudo yum erase -y python34
sudo yum install -y devtoolset-4-runtime
#sudo yum install -y devtoolset-4-gcc-c++
#sudo yum install -y devtoolset-4-libstdc++-devel

source /opt/rh/devtoolset-4/enable

VERSION="0.9.0"
RPM_SRC_FILE="flannel-0.9.0-1.fc28.src.rpm"

SRC_DIR=src

if [ ! -d ${CUR_DIR}/${SRC_DIR} ] ; then
    mkdir -p ${CUR_DIR}/${SRC_DIR}
fi

if [ ! -f ${CUR_DIR}/${SRC_DIR}/${RPM_SRC_FILE} ] ; then
    sudo wget -O ${CUR_DIR}/${SRC_DIR}/${RPM_SRC_FILE} http://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Everything/source/tree/Packages/f/${RPM_SRC_FILE}
    pushd ${CUR_DIR}/${SRC_DIR} > /dev/null
    rpm2cpio ${RPM_SRC_FILE} | cpio -div
    popd > /dev/null
fi

#sed -i 's/x86_64/aarch64/g' ${CUR_DIR}/${SRC_DIR}/flannel.spec

${CUR_DIR}/../../utils/rpm_build.sh  ${CUR_DIR}/${SRC_DIR} flannel.spec
