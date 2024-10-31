#!/usr/bin/bash
IMAGE_TAG=$1
if [ $IMAGE_TAG ]; then
                docker build $(dirname $0) --file Dockerfile -t $IMAGE_TAG
        else
                docker --debug build $(dirname $0) --file Dockerfile -t sleechengn/ubuntu:jammy
fi
