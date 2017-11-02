#!/bin/sh

if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi

if [ "$DOCKER_REGISTRY_URL" = "docker.io" ]; then
  docker login -u $DOCKER_USER -p $DOCKER_PASS
  DOCKER_IMAGE="$DOCKER_USER/$HEROKU_APP_NAME:$TAG"
else
  docker login -u $DOCKER_USER -p $DOCKER_PASS $DOCKER_REGISTRY_URL
  DOCKER_IMAGE="$DOCKER_REGISTRY_URL/$DOCKER_USER/$HEROKU_APP_NAME:$TAG" 
fi

docker build -f Dockerfile -t $DOCKER_IMAGE .
docker push $DOCKER_IMAGE