#!/bin/sh

docker login -u $DOCKER_USER -p $DOCKER_PASS $DOCKER_REGISTRY_URL

if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi

if [ "$DOCKER_REGISTRY_URL" = "docker.io" ]; then
  DOCKER_IMAGE="$DOCKER_USER/$HEROKU_APP_NAME:$TAG"
else
  DOCKER_IMAGE="$DOCKER_REGISTRY_URL/$DOCKER_USER/$HEROKU_APP_NAME:$TAG" 
fi

echo $DOCKER_IMAGE;

docker build -f Dockerfile -t $DOCKER_IMAGE .
docker push $DOCKER_IMAGE