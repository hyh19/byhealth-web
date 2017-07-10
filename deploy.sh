#!/bin/bash

# 执行脚本的参数是前端源码包的路径
TAR_FILE=${1}

# 判断有没有传参数
if [ -z ${TAR_FILE} ]
then
	echo "[ERROR] missing parameter"
	echo "[USAGE] deploy.sh /path/to/tar/file"
	exit 1
fi

# 判断源码包是否存在
if [ ! -e ${TAR_FILE} ]
then
	echo "[ERROR] tar file is not exist."
	exit 1
fi

# build文件夹，解压源码包存放的位置。
BUILD_DIR=./build

# 如果旧的代码存在，则先清空，然后再重新解压。
if [ -d ${BUILD_DIR} ]
then
	rm -rf ${BUILD_DIR}
fi

# Dockerfile的路径
DOCKER_FILE=./Dockerfile

# .dockerignore的路径
DOCKER_IGNORE_FILE=./.dockerignore

# 重新解压代码
tar xvf ${TAR_FILE}

# 拷贝Dockerfile和.dockerignore到build文件夹
cp ${DOCKER_FILE} ${DOCKER_IGNORE_FILE} ${BUILD_DIR}

# 开始部署
docker-compose up
