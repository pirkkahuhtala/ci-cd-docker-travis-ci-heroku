#!/bin/sh
docker login -u $DOCKER_USER -p $DOCKER_PASS $DOCKER_REGISTRY_URL
if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi
docker build -f Dockerfile -t "$DOCKER_REGISTRY_URL/$DOCKER_USER/$TRAVIS_REPO_SLUG:$TAG .
docker push $TRAVIS_REPO_SLUG