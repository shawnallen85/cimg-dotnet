#!/usr/bin/env bash

BUILD_CMD="docker build"

if command -v buildah &> /dev/null
then
    BUILD_CMD="buildah bud"
fi

${BUILD_CMD} --file 3.1/Dockerfile -t cimg/dotnet:3.1 .
${BUILD_CMD} --file 3.1/node/Dockerfile -t cimg/dotnet:3.1-node .
${BUILD_CMD} --file 3.1/browsers/Dockerfile -t cimg/dotnet:3.1-browsers .

${BUILD_CMD} --file 6.0/Dockerfile -t cimg/dotnet:6.0 .
${BUILD_CMD} --file 6.0/node/Dockerfile -t cimg/dotnet:6.0-node .
${BUILD_CMD} --file 6.0/browsers/Dockerfile -t cimg/dotnet:6.0-browsers .
