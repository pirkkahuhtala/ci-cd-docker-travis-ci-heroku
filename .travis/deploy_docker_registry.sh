#!/bin/sh


docker login -u $DOCKER_USER -p $DOCKER_PASS $DOCKER_REGISTRY_URL
if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi

if [ "$DOCKER_REGISTRY_URL" = "docker.io"]; then
  DOCKER_IMAGE="$HEROKU_APP_NAME:$TAG"
else
  DOCKER_IMAGE="$HEROKU_APP_NAME:$TAG" 
fi

docker build -f Dockerfile -t $DOCKER_IMAGE .
docker push $DOCKER_IMAGE