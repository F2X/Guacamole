#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH="$(dirname "$SCRIPT")"

UPDATE_TYPE='major'

DESCRIBE=`git describe --tags --always`

# increment the build number (ie 115 to 116)
MAJOR=`echo $DESCRIBE | awk '{split($0,a,"."); print a[1]}'`
MINOR=`echo $DESCRIBE | awk '{split($0,a,"."); print a[2]}'`
PATCH=`echo $DESCRIBE | awk '{split($0,a,"."); print a[3]}'`

echo "Current version: ${DESCRIBE}"

case ${UPDATE_TYPE} in
    major ) MAJOR=$((MAJOR+1))
        ;;
    minor) MINOR=$((MINOR+1))
        ;;
    patch ) PATCH=$((PATCH+1))
        ;;
    * ) echo "Wrong update-type (major|minor|patch)." && exit -1
esac
UPDATE_VERSION=${MAJOR}.${MINOR}.${PATCH}
echo "Update version: ${UPDATE_VERSION}"

git tag ${UPDATE_VERSION}
git checkout -b ${UPDATE_VERSION}-release
git rebase -i ${DESCRIBE}

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

exit 0