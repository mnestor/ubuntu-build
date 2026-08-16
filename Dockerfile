FROM ubuntu:24.04

LABEL org.opencontainers.image.source="https://github.com/mnestor/ubuntu-build"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.description="ubuntu image with build tools and certficate chain"

# Improve build speed by specifying the fastly CDN for apt-repository
ARG DEBIAN_FRONTEND=noninteractive
ENV APT_MIRROR=cdn-fastly.deb.debian.org
RUN sed -ri "s/(httpredir|deb).debian.org/${APT_MIRROR:-deb.debian.org}/g" /etc/apt/sources.list \
 && sed -ri "s/(security).debian.org/${APT_MIRROR:-security.debian.org}/g" /etc/apt/sources.list

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y sudo libatomic1 \
      build-essential ca-certificates wget \
      gnupg git curl unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*