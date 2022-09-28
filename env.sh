#!/bin/bash
# This file is generated by build.xml
FR_DIR="`pwd`/${BASH_SOURCE%/*}/"
if [[ ! -d "${FR_DIR}download/" ]]; then
	mkdir "${FR_DIR}download/"
fi
if [[ ! -d "${FR_DIR}build/tmp/build" ]]; then
	mkdir -p "${FR_DIR}build/tmp/build"
fi
ZIP=OpenJDK8U-jdk_x64_linux_hotspot_8u292b10.tar.gz
URL=https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_linux_hotspot_8u292b10.tar.gz
DIR=build/jdk8u292-b10
SUB=
if [[ "$OSTYPE" == "darwin"* ]]; then
	ZIP=OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz
	URL=https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz
	SUB=Contents/Home
fi
DOWNLOAD_HELP="download ${URL} manually, move it to ${FR_DIR}download and restart this script"
if [[ ! -f "${FR_DIR}download/${ZIP}" ]]; then
	echo In case of errors ${DOWNLOAD_HELP}
	curl -f -o "${FR_DIR}download/${ZIP}.tmp" -L ${URL}
	retVal=$?
	if [[ $retVal -ne 0 ]]; then
		echo "Please ${DOWNLOAD_HELP}"
		exit $retVal
	fi
	mv "${FR_DIR}download/${ZIP}.tmp" "${FR_DIR}/download/${ZIP}"
fi
if [[ ! -d "${FR_DIR}${DIR}/" ]]; then
	tar --exclude=*/demo --exclude=*/sample --exclude=*/manual --exclude=*/src.zip -xzvf "${FR_DIR}download/${ZIP}" -C "${FR_DIR}build/tmp/build"
	retVal=$?
	if [[ $retVal -ne 0 ]]; then
		echo "Please ${DOWNLOAD_HELP}"
		exit $retVal
	fi
	mv "${FR_DIR}build/tmp/${DIR}//${SUB}" "${FR_DIR}${DIR}"
fi
ZIP=apache-ant-1.10.10-bin.tar.gz
URL=https://archive.apache.org/dist/ant/binaries/apache-ant-1.10.10-bin.tar.gz
DIR=build/apache-ant-1.10.10
SUB=
DOWNLOAD_HELP="download ${URL} manually, move it to ${FR_DIR}download and restart this script"
if [[ ! -f "${FR_DIR}download/${ZIP}" ]]; then
	echo In case of errors ${DOWNLOAD_HELP}
	curl -f -o "${FR_DIR}download/${ZIP}.tmp" -L ${URL}
	retVal=$?
	if [[ $retVal -ne 0 ]]; then
		echo "Please ${DOWNLOAD_HELP}"
		exit $retVal
	fi
	mv "${FR_DIR}download/${ZIP}.tmp" "${FR_DIR}/download/${ZIP}"
fi
if [[ ! -d "${FR_DIR}${DIR}/" ]]; then
	tar --exclude=*/demo --exclude=*/sample --exclude=*/manual --exclude=*/src.zip -xzvf "${FR_DIR}download/${ZIP}" -C "${FR_DIR}build/tmp/build"
	retVal=$?
	if [[ $retVal -ne 0 ]]; then
		echo "Please ${DOWNLOAD_HELP}"
		exit $retVal
	fi
	mv "${FR_DIR}build/tmp/${DIR}//${SUB}" "${FR_DIR}${DIR}"
fi
set JDK_8_DIR="${FR_DIR}build/jdk8u292-b10"
set JDK_11_DIR="${FR_DIR}build/jdk-11.0.11+9"
if [[ ! -d "${JDK_11_DIR}" ]]; then
	"${FR_DIR}build/apache-ant-1.10.10/bin/ant" -emacs
fi
export JAVA_HOME="${JDK_8_DIR}"
export ANT_HOME="${FR_DIR}build/apache-ant-1.10.10"
export PATH="${FR_DIR}${JDK_DIR}/bin:${FR_DIR}build/apache-ant-1.10.10/bin:${FR_DIR}build/apache-maven-3.8.4/bin:${PATH}"
