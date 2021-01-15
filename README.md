## docker-plex

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/plex) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/plex?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-plex/actions?query=workflow%3A"Auto+Builder+CI") [![codacy branch grade](https://img.shields.io/codacy/grade/0ee0399940b24ddcaf834284ab75e952/main?style=for-the-badge&logo=codacy)](https://app.codacy.com/gh/hydazz/docker-plex)

Fork of [linuxserver/docker-plex](https://github.com/linuxserver/docker-plex/)

[Plex](https://plex.tv) organises video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices. This container is packaged as a standalone Plex Media Server. has always been a top priority. Straightforward design and bulk actions mean getting things done faster.

## Version Information

![ubuntu](https://img.shields.io/badge/ubuntu-groovy-E95420?style=for-the-badge&logo=ubuntu) ![s6 overlay](https://img.shields.io/badge/s6_overlay-2.1.0.2-blue?style=for-the-badge) ![plex](https://img.shields.io/badge/plex-1.21.1.3876-E5A00D?style=for-the-badge&logo=plex)

See [package_versions.txt](package_versions.txt) for a full list of the packages and package versions used in this image

## Usage

    docker run -d \
      --name=plex \
      --net=host \
      -e PUID=1000 \
      -e PGID=1000 \
      -e VERSION=docker \
      -e UMASK_SET=022 `#optional` \
      -e PLEX_CLAIM= `#optional` \
      -v <path to appdata>:/config \
      -v <path to tv>:/tv \
      -v <path to movies>:/movies \
      --restart unless-stopped \
      vcxpz/plex

[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/plex.xml)

**Read the official [README.md](https://github.com/linuxserver/docker-plex/) for more information**
