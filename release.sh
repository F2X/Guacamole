#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH="$(dirname "$SCRIPT")"

DESCRIBE=`git describe --tags --always`

# increment the build number (ie 115 to 116)
MAJOR=`echo $DESCRIBE | awk '{split($0,a,"."); print a[1]}'`
MINOR=`echo $DESCRIBE | awk '{split($0,a,"."); print a[2]}'`
PATCH=`echo $DESCRIBE | awk '{split($0,a,"."); print a[3]}'`
#
#if [[ "${DESCRIBE}" =~ ^[A-Fa-f0-9]+$ ]]; then
#    VERSION="0.0.0"
#    BUILD=`git rev-list HEAD --count`
#    PATCH=${DESCRIBE}
#fi
#
#if [ "${BUILD}" = "" ]; then
#    BUILD='0'
#fi
#
#if [ "${BUILD}" = "" ]; then
#    PATCH=$DESCRIBE
#fi
#
#
#echo ${VERSION}+build.${BUILD}.${PATCH}

echo "major: " + ${MAJOR}
echo "minor: " + ${MINOR}
echo "patch: " + ${PATCH}