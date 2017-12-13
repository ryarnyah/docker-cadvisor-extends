#!/usr/bin/env bash
set -e

VERSION=$( git describe --tags --dirty --abbrev=14 | sed -E 's/-([0-9]+)-g/.\1+/' )
# Only allow releases of tagged versions.
TAGGED='^v[0-9]+\.[0-9]+\.[0-9]+(-(alpha|beta)[0-9]*)?$'
if [[ ! "$VERSION" =~ $TAGGED ]]; then
  echo "Error: Only tagged versions are allowed for releases" >&2
  echo "Found: $VERSION" >&2
  exit 1
fi

# Build the release.
export BUILD_USER="ryarnyah@gmail.com"
export BUILD_DATE=$( date +%Y%m%d ) # Release date is only to day-granularity
export GO_CMD="build" # Don't use cached build objects for releases.
export VERBOSE=true
build/build.sh
