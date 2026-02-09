#!/usr/bin/env bash
set -e

SERVICE=$1

if [ -z "$SERVICE" ]; then
  echo "Usage: next-version.sh <backend|frontend>"
  exit 1
fi

LAST_TAG=$(git tag --list "${SERVICE}-v*" --sort=-v:refname | head -n 1)

if [ -z "$LAST_TAG" ]; then
  NEXT_VERSION="1.0"
else
  VERSION=${LAST_TAG#"$SERVICE-v"}
  MAJOR=${VERSION%%.*}
  MINOR=${VERSION##*.}
  NEXT_VERSION="$MAJOR.$((MINOR + 1))"
fi

echo "$NEXT_VERSION"

