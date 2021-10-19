
FROM debian:bullseye-slim

LABEL org.opencontainers.image.title="PKI Tool Docker Image" \
      org.opencontainers.image.description="Docker image for PKI Tool" \
      org.opencontainers.image.documentation="https://github.com/buanet/pkitool.docker#readme" \
      org.opencontainers.image.authors="André Germann <info@buanet.de>" \
      org.opencontainers.image.url="https://github.com/buanet/pkitool.docker" \
      org.opencontainers.image.source="https://github.com/buanet/pkitool.docker" \
      org.opencontainers.image.base.name="docker.io/library/debian:bullseye-slim" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.created="${DATI}"

ENV DEBIAN_FRONTEND noninteractive

# install rerequisites
RUN apt-get update && apt-get install -y \
    #for pkitool
    git \
    dos2unix \
    zip \
    unzip \
    tree \
    openssl \
    iproute2 \
    vim \
    # for web access via shellinabox
    shellinabox \
    # personal
    nano \
    # Clean up installation cache
    && apt-get autoclean -y \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /root/.cache/* \
    && rm -rf /var/lib/apt/lists/*

# Create scripts directorys and copy scripts
RUN mkdir -p /opt/scripts/ \
    && chmod 777 /opt/scripts/
WORKDIR /opt/scripts/
COPY scripts/* ./
RUN chmod +x *.sh

# Add User for pkitool
RUN useradd pki \
    && usermod -a -G pki pki \
    && echo pki:pki | chpasswd \
    && chsh -s /bin/bash pki \
    && mkdir /home/pki \
    && usermod --home /home/pki pki

EXPOSE 4200

# Run startup-script
ENTRYPOINT ["/bin/bash", "-c", "/opt/scripts/startup.sh"]
