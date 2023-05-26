# Dockerfile for ASHS (fast-ashs) version
FROM pyushkevich/itksnap:v3.8.2

ENV FLYWHEEL=/flywheel/v0
ENV FLYWHEEL_INPUT=${FLYWHEEL}/input
ENV FLYWHEEL_OUTPUT=${FLYWHEEL}/output

# Descriptor fields
LABEL version="fastashs-1.0.0"
LABEL maintainer="pyushkevich@gmail.com"
LABEL description="ASHS base image"

COPY atlases/ASHS-PMC-T1.tgz /app/atlas/data/ASHS-PMC-T1.tgz
COPY atlases/ASHS-PMC.tgz /app/atlas/data/ASHS-PMC.tgz
COPY atlases/ASHS-ABC-3T.tgz /app/atlas/data/ASHS-ABC-3T.tgz
COPY atlases/ASHS-ABC-7T.tgz /app/atlas/data/ASHS-ABC-7T.tgz
COPY atlases/ASHS-Magdeburg.tgz /app/atlas/data/ASHS-Magdeburg.tgz
COPY atlases/ASHS-HarP.tgz /app/atlas/data/ASHS-HarP.tgz
COPY atlases/ASHS-ICV.tgz /app/atlas/data/ASHS-ICV.tgz
COPY atlases/ASHS-Princeton.tgz /app/atlas/data/ASHS-Princeton.tgz
COPY atlases/ASHS-Utrecht.tgz /app/atlas/data/ASHS-Utrecht.tgz

# Make sure we have git, curl and other basics
RUN apt-get update
RUN apt-get install -y bc curl git parallel imagemagick wget unzip wget jq git time

# Set the working directory for the ASHS app
WORKDIR ${FLYWHEEL}

# Copy the current scriptlet
COPY docker-ashs-base /app/

COPY config.json config.test.json manifest.json run runall ${FLYWHEEL}/
COPY AshsAtlasesConfig.json /app/AshsAtlasesConfig.json
COPY testdata ${FLYWHEEL}/testdata

