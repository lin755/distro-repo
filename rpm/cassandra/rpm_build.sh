#!/bin/bash

CUR_DIR="$(cd `dirname $0`; pwd)"
TARGET_OS="centos"
if [ ! -z "${1}" ] ; then
    TARGET_OS=${1}
fi

OLD_VERSION="3.0.13"
NEW_VERSION="3.10"

RPM_SRC_FILE="apache-cassandra-${NEW_VERSION}-src.tar.gz"
SUB_DIR="30x"
SRC_DIR=src-cassandra

if [ ! -f ${CUR_DIR}/${SRC_DIR}/${RPM_SRC_FILE} ] ; then
    if [ ! -d ${CUR_DIR}/${SRC_DIR} ] ; then
        mkdir -p ${CUR_DIR}/${SRC_DIR}
    fi 
    wget -O ${CUR_DIR}/${SRC_DIR}/${RPM_SRC_FILE}  http://mirrors.hust.edu.cn/apache/cassandra/${NEW_VERSION}/${RPM_SRC_FILE}
fi

sed -i "s/${OLD_VERSION}/${NEW_VERSION}/g" ${CUR_DIR}/${SRC_DIR}/cassandra.spec

${CUR_DIR}/../../utils/rpm_build.sh  ${CUR_DIR}/${SRC_DIR} cassandra.spec
