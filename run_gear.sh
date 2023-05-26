#!/bin/bash

IMAGE=ashs:0.1.11
BASEDIR=/data/holder/Ashs
CURDIR=${BASEDIR}/docker-ashs-base

# Command:
docker run --rm -it --entrypoint='/bin/bash'\
	-e PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\
	-e FLYWHEEL=/flywheel/v0\
	-v ${BASEDIR}/data/input:/flywheel/v0/input/T1w\
	-v ${BASEDIR}/data/input:/flywheel/v0/input/T2w\
	-v ${BASEDIR}/data/mywork:/flywheel/v0/mywork\
	-v ${BASEDIR}/data/output:/flywheel/v0/output\
	$IMAGE

