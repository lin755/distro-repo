#!/bin/bash

CUR_DIR=$(cd `dirname $0`; pwd)

sudo yum install -y devtoolset-4-gcc
sudo yum install -y devtoolset-4-gcc-c++
sudo yum install -y devtoolset-4-libstdc++-devel
source /opt/rh/devtoolset-4/enable

MAJOR_VERSION="57"
RPM_SRC_FILE="Percona-Server-57-5.7.17-13.1.generic.src.rpm"

SRC_DIR=src${MAJOR_VERSION}

if [ ! -f ${CUR_DIR}/${SRC_DIR}/${RPM_SRC_FILE} ] ; then
    if [ ! -d ${CUR_DIR}/${SRC_DIR} ] ; then
        mkdir -p ${CUR_DIR}/${SRC_DIR}
    fi

    sudo wget -O ${CUR_DIR}/${SRC_DIR}/${RPM_SRC_FILE} https://repo.percona.com/centos/6/SRPMS/${RPM_SRC_FILE}
    pushd ${CUR_DIR}/${SRC_DIR} > /dev/null
    rpm2cpio ${RPM_SRC_FILE} | cpio -div
    popd > /dev/null
fi

#sed -i 's/x86_64/aarch64/g' ${CUR_DIR}/${SRC_DIR}/percona-server.spec

${CUR_DIR}/../../utils/rpm_build.sh  ${CUR_DIR}/${SRC_DIR} percona-server.spec
