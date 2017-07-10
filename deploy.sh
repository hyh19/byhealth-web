#!/bin/bash

# 源码包的路径
TAR_FILE=${1}

# 判断有没有源码包路径作为参数
if [ -z ${TAR_FILE} ]
then
	echo "[USAGE] deploy.sh /path/to/tar/file"
	exit 1
fi

# 判断源码包是否存在
if [ ! -e ${TAR_FILE} ]
then
	echo "[ERROR] file is not exist."
	exit 1
fi

# build文件夹，源码放置的位置。
BUILD_DIR=./build

# 清空原来的代码
if [ -d ${BUILD_DIR} ]
then
	rm -rf ${BUILD_DIR}
fi

# 重新解压代码
tar xvf ${TAR_FILE}

cp Dockerfile .dockerignore build

# 开始部署
docker-compose up
