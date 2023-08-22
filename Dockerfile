FROM docker.io/panubo/s3fs:1.87

RUN apt-get update && apt-get install -y \
  awscli \
  && rm -rf /var/lib/apt/lists/*
