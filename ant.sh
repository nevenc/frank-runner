#!/bin/bash
# This file is generated by build.xml
FR_DIR="`pwd`/${BASH_SOURCE%/*}/"
if [[ ${BASH_SOURCE:0:1} == "/" ]]; then
  # Workaround for VSCode Task Explorer on Mac and Linux
  FR_DIR="${BASH_SOURCE%/*}/"
fi
if [[ ! -d "${FR_DIR}download/" ]]; then
	mkdir "${FR_DIR}download/"
fi
if [[ ! -d "${FR_DIR}build/tmp/build" ]]; then
	mkdir -p "${FR_DIR}build/tmp/build"
fi
ZIP=OpenJDK11U-jdk_x64_linux_hotspot_11.0.21_9.tar.gz
URL=https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.21+9/OpenJDK11U-jdk_x64_linux_hotspot_11.0.21_9.tar.gz
DIR=build/jdk-11.0.21+9
SUB=
if [[ "$OSTYPE" == "darwin"* ]]; then
	ZIP=OpenJDK11U-jdk_x64_mac_hotspot_11.0.21_9.tar.gz
	URL=https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.21+9/OpenJDK11U-jdk_x64_mac_hotspot_11.0.21_9.tar.gz
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
ZIP=rhino-1.7.14.zip
URL=https://github.com/mozilla/rhino/releases/download/Rhino1_7_14_Release/rhino-1.7.14.zip
DIR=${dir}
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
	unzip "${FR_DIR}download/${ZIP}" -d "${FR_DIR}build/tmp/build"
	retVal=$?
	if [[ $retVal -ne 0 ]]; then
		echo "Please ${DOWNLOAD_HELP}"
		exit $retVal
	fi
	mv "${FR_DIR}build/tmp/${DIR}//${SUB}" "${FR_DIR}${DIR}"
fi
if [[ ! -f "${FR_DIR}build/apache-ant-1.10.10/lib/rhino-1.7.14.jar" ]]; then
	rm "${FR_DIR}build/apache-ant-1.10.10/lib/rhino-*.jar"
	cp "${FR_DIR}build/rhino1.7.14/lib/rhino-*.jar" "${FR_DIR}build/apache-ant-1.10.10/lib/"
)
JDK_8_DIR="${FR_DIR}build/jdk8u392-b08"
JDK_11_DIR="${FR_DIR}build/jdk-11.0.21+9"
JDK_17_DIR="${FR_DIR}build/jdk-17.0.8+7"
JDK_21_DIR="${FR_DIR}build/jdk-21.0.1+12"
if [[ ! -d "${JDK_8_DIR}" ]]; then
	RUN_INSTALL="true"
fi
if [[ ! -d "${JDK_11_DIR}" ]]; then
	RUN_INSTALL="true"
fi
if [[ ! -d "${JDK_17_DIR}" ]]; then
	RUN_INSTALL="true"
fi
export JAVA_HOME="${JDK_21_DIR}"
export ANT_HOME="${FR_DIR}build/apache-ant-1.10.10"
if [[ "$RUN_INSTALL" == "true" ]]; then
	"${FR_DIR}build/apache-ant-1.10.10/bin/ant" -emacs -buildfile "${FR_DIR}build.xml" install
fi
"${FR_DIR}build/apache-ant-1.10.10/bin/ant" -Dfr.jdk.8.dir="${JDK_8_DIR}" -Dfr.jdk.11.dir="${JDK_11_DIR}" -Dfr.jdk.17.dir="${JDK_17_DIR}" -Dfr.jdk.21.dir="${JDK_21_DIR}" -emacs "$@"