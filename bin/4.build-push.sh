#!/bin/bash
# Build images, tag them, and push them to the local registry
IMAGE_TAG="latest"

docker build -t weather-app:$IMAGE_TAG ./apps/weather
docker build -t dice-app:$IMAGE_TAG ./apps/dice

docker tag weather-app:$IMAGE_TAG localhost:5001/weather-app:$IMAGE_TAG
docker tag dice-app:$IMAGE_TAG localhost:5001/dice-app:$IMAGE_TAG

docker push localhost:5001/weather-app:$IMAGE_TAG
docker push localhost:5001/dice-app:$IMAGE_TAG
