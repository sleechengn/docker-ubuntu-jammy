#!/usr/bin/bash

if [ -e "$(dirname $0)/Dockerfile.run.build" ]; then
	IMAGE_TAG=$1
        VERSION=$(echo $IMAGE_TAG|awk -F "ubuntu-$(arch):" '{print $2}')
        if [ ! "$VERSION" ]; then VERSION=jammy; fi
	if [ $IMAGE_TAG ]; then
                docker build $(dirname $0) --build-arg VERSION=$VERSION --file Dockerfile.run.build -t $IMAGE_TAG
        else
                docker --debug build $(dirname $0) --build-arg VERSION=$VERSION --file Dockerfile.run.build -t sleechengn/ubuntu:$VERSION
	fi
else
	IMAGE_TAG=$1
        VERSION=$(echo $IMAGE_TAG|awk -F "ubuntu-$(arch):" '{print $2}')
        if [ ! "$VERSION" ]; then VERSION=jammy; fi
	if [ $IMAGE_TAG ]; then
                docker build $(dirname $0) --build-arg VERSION=$VERSION --file Dockerfile -t $IMAGE_TAG
        else
                docker --debug build $(dirname $0) --build-arg VERSION=$VERSION --file Dockerfile -t sleechengn/ubuntu:$VERSION
	fi
fi
