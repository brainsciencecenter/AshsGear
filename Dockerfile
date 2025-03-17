# Dockerfile for ASHS (fast-ashs) version
FROM pyushkevich/itksnap:v3.8.2

ENV FLYWHEEL=/flywheel/v0
ENV FLYWHEEL_INPUT=${FLYWHEEL}/input
ENV FLYWHEEL_OUTPUT=${FLYWHEEL}/output
ENV PATH=${FLYWHEEL}:${FLYWHEEL}/flywheel/bin:$PATH
ENV PYTHONPATH=/usr/local/lib/python3.9/site-packages:${FLYWHEEL}/flywheel/lib

# Descriptor fields
LABEL version="fastashs-1.0.0"
LABEL maintainer="pyushkevich@gmail.com"
LABEL description="ASHS base image"

# Make sure we have git, curl and other basics
RUN apt-get update
RUN apt-get install -y			\
			autoconf	\
			bc		\
			build-essential	\
    	    	        curl		\
		        git		\
			jq		\
			imagemagick	\
			libtool		\
			parallel 	\
			python3		\
			time		\
			unzip		\
			vim		\
			wget

RUN wget -O /tmp/fw-linux.zip https://storage.googleapis.com/flywheel-dist/cli/19.0.5/fw-linux_amd64-19.0.5.zip
RUN (cd /tmp; unzip fw-linux.zip; cp linux_amd64/fw /usr/local/bin/)

# Set the working directory for the ASHS app
WORKDIR ${FLYWHEEL}

ENV FLYWHEELSITEVERSION=19.5.1
RUN pip3 install	flywheel-sdk"<="${FLYWHEELSITEVERSION}	\
    	 		flywheel-gear-toolkit			\
			globre					\
			pytz					\
			pyjq					\
			tzlocal

# Copy the current scriptlet
COPY docker-ashs-base /app/

COPY    ashsPrepT1T2Inputs	\
	ashsFwResultsHandler	\
	copyFile2Output		\
     	config.json		\
	genMetadataFile		\
	manifest.json		\
	run			\
	runall			\
	trim_neck.sh		\
	txt2json		\
	${FLYWHEEL}/

RUN chmod 755 ashsFwResultsHandler run runall trim_neck.sh txt2json
COPY AshsAtlasesConfig.json /app/AshsAtlasesConfig.json
COPY testdata ${FLYWHEEL}/testdata

