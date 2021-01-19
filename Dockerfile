ARG TAG
FROM vcxpz/baseimage-ubuntu:groovy

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Plex version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
   PLEX_DOWNLOAD="https://downloads.plex.tv/plex-media-server-new" \
   PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config/Library/Application Support" \
   PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver" \
   PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="6" \
   PLEX_MEDIA_SERVER_USER="abc" \
   PLEX_MEDIA_SERVER_INFO_VENDOR="Docker" \
   PLEX_MEDIA_SERVER_INFO_DEVICE="Docker Container (hyadz)"

RUN \
   echo "**** install runtime packages ****" && \
   apt-get update && \
   apt-get install -y \
     jq \
     udev \
     unrar \
     wget && \
   if [ "$(arch)" = "x86_64" ]; then \
     apt-get install -y \
          beignet-opencl-icd \
          ocl-icd-libopencl1; \
     COMP_RT_RELEASE=$(curl -sX GET "https://api.github.com/repos/intel/compute-runtime/releases/latest" | jq -r '.tag_name'); \
     COMP_RT_URLS=$(curl -sX GET "https://api.github.com/repos/intel/compute-runtime/releases/tags/${COMP_RT_RELEASE}" | jq -r '.body' | grep wget | sed 's|wget ||g'); \
     mkdir -p /opencl-intel; \
     for i in ${COMP_RT_URLS}; do \
          i=$(echo ${i} | tr -d '\r'); \
          echo "**** downloading ${i} ****"; \
          curl --silent -o "/opencl-intel/$(basename ${i})" \
              -L "${i}"; \
     done; \
     dpkg -i /opencl-intel/*.deb; \
     rm -rf /opencl-intel; \
     export NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"; \
   fi && \
   PLEX_ARCH=$(curl -sSL https://raw.githubusercontent.com/hydazz/scripts/main/docker/ubuntu-archer.sh | bash) && \
   echo "**** install plex ****" && \
   curl --silent -o \
     /tmp/plexmediaserver.deb -L \
     "${PLEX_DOWNLOAD}/${VERSION}/debian/plexmediaserver_${VERSION}_${PLEX_ARCH}.deb" && \
   dpkg -i /tmp/plexmediaserver.deb && \
   echo "**** ensure abc user's home folder is /app ****" && \
   usermod -d /app abc && \
   echo "**** cleanup ****" && \
   apt-get clean && \
   rm -rf \
     /etc/default/plexmediaserver \
     /tmp/* \
     /var/lib/apt/lists/* \
     /var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 32400/tcp 1900/udp 3005/tcp 5353/udp 8324/tcp 32410/udp 32412/udp 32413/udp 32414/udp 32469/tcp
VOLUME /config
