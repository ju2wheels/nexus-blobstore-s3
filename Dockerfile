FROM maven:3-jdk-8-alpine

ARG NEXUS_BUILD=01
ARG NEXUS_VERSION=3.11.0

VOLUME ["/target"]

COPY . /nexus-blobstore-s3/

RUN sed -i "s/3.10.0-04/${NEXUS_VERSION}-${NEXUS_BUILD}/g" /nexus-blobstore-s3/pom.xml
RUN echo -e '#!/bin/bash\nmvn package && rm -rf /root/.m2 && cp ./target/nexus-blobstore-s3-*-SNAPSHOT.jar /target' >> /usr/bin/nexus-blobstore-s3-build && \
    chmod 755 /usr/bin/nexus-blobstore-s3-build

WORKDIR /nexus-blobstore-s3

ENTRYPOINT ["/usr/bin/nexus-blobstore-s3-build"]
