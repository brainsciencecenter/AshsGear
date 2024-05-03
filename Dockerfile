# Dockerfile for ASHS (fast-ashs) version
FROM pyushkevich/itksnap:v3.8.2

ENV FLYWHEEL=/flywheel/v0
ENV FLYWHEEL_INPUT=${FLYWHEEL}/input
ENV FLYWHEEL_OUTPUT=${FLYWHEEL}/output
ENV PYTHONPATH=/usr/local/lib/python3.9/site-packages:/usr/local/flywheel/lib

# Descriptor fields
LABEL version="fastashs-1.0.0"
LABEL maintainer="pyushkevich@gmail.com"
LABEL description="ASHS base image"


COPY fw /usr/local/bin/fw

# Make sure we have git, curl and other basics
RUN apt-get update
RUN apt-get install -y bc curl git parallel imagemagick wget unzip wget jq git time build-essential autoconf libtool python3

# Set the working directory for the ASHS app
WORKDIR ${FLYWHEEL}

RUN pip3 install flywheel-sdk globre pytz pyjq tzlocal

# Copy the current scriptlet
COPY docker-ashs-base /app/

COPY ashsFwResultsHandler config.json manifest.json run runall trim_neck.sh ${FLYWHEEL}/
RUN chmod 755 ashsFwResultsHandler run runall trim_neck.sh
COPY AshsAtlasesConfig.json /app/AshsAtlasesConfig.json
COPY testdata ${FLYWHEEL}/testdata

