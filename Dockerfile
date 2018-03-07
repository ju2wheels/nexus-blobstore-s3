FROM maven:3-jdk-8-alpine

VOLUME ["/target"]

COPY . /nexus-blobstore-s3/
RUN  echo -e '#!/bin/bash\nmvn package && rm -rf /root/.m2 && cp ./target/nexus-blobstore-s3-*-SNAPSHOT.jar /target' >> /usr/bin/nexus-blobstore-s3-build && \
     chmod 755 /usr/bin/nexus-blobstore-s3-build

WORKDIR /nexus-blobstore-s3

ENTRYPOINT ["/usr/bin/nexus-blobstore-s3-build"]
