#!/bin/bash

sed -i -E \
	-e "s/plex-.*?-E5A00D/plex-${APP_VERSION//-*/}-E5A00D/g" \
	README.md
