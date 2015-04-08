#!/bin/sh -x

SCRIPT=$(readlink -f "$0")
SCRIPTPATH="$(dirname "$SCRIPT")"

UPDATE_TYPE='patch'

DESCRIBE=`git describe --tags`

MAJOR=`echo ${DESCRIBE} | awk '{split($0,a,"."); print a[1]}'`
MINOR=`echo ${DESCRIBE} | awk '{split($0,a,"."); print a[2]}'`
PATCH=`echo ${DESCRIBE} | awk '{split($0,a,"."); print a[3]}' | awk '{split($0,a,"-"); print a[1]}'`

echo "Current version: ${DESCRIBE}"
# hack to remove 'v'
MAJOR=$((MAJOR+0))

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
SHA1=$(git log -n 1 --pretty=format:"%H" master)
echo "Cherry-pick commit: ${SHA1}"
git checkout github-master
git cherry-pick ${SHA1}
git tag v${UPDATE_VERSION}

exit 0