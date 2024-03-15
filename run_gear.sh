#!/bin/bash

IMAGE=$(jq -r '.custom["gear-builder"].image' manifest.json)
BASEDIR=/data/holder/Ashs
CURDIR=${BASEDIR}/docker-ashs-base

# Command:
docker run --rm -it --entrypoint='/bin/bash'\
	-e FLYWHEEL=/flywheel/v0\
        -v /home/holder/.config/flywheel:/root/.config/flywheel \
	-v ${BASEDIR}/data/input:/flywheel/v0/input/T1w\
	-v ${BASEDIR}/data/input:/flywheel/v0/input/T2w\
	-v ${BASEDIR}/data/mywork:/flywheel/v0/mywork\
	-v ${BASEDIR}/data/output:/flywheel/v0/output\
	$IMAGE

