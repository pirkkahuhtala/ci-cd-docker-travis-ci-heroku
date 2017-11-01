#!/bin/sh

if [ "$DOCKER_REGISTRY_URL" = "docker.io"]; then
  REAL_DOCKER_REGISTRY_URL=""
else
  REAL_DOCKER_REGISTRY_URL="$DOCKER_REGISTRY_URL/"
fi

docker login -u $DOCKER_USER -p $DOCKER_PASS $REAL_DOCKER_REGISTRY_URL
if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi
docker build -f Dockerfile -t "$REAL_DOCKER_REGISTRY_URL$HEROKU_APP_NAME:$TAG" .
docker push "$DOCKER_REGISTRY_URL/$HEROKU_APP_NAME:$TAG"