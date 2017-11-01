#!/bin/sh
docker login -u $DOCKER_USER -p $DOCKER_PASS $DOCKER_REGISTRY_URL
if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi
docker build -f Dockerfile -t "$DOCKER_REGISTRY_URL/$HEROKU_APP_NAME:$TAG" .
docker push "$DOCKER_REGISTRY_URL/$HEROKU_APP_NAME:$TAG"