#!/bin/bash
# Build images, tag them, and push them to the local registry
IMAGE_TAG="latest"

docker build -t weather-app:$IMAGE_TAG ./apps/weather
docker build -t dice-app:$IMAGE_TAG ./apps/dice
docker build -t pod-metadata-app:$IMAGE_TAG ./apps/pod-metadata
docker build -t dogs-app:$IMAGE_TAG ./apps/dogs

docker tag weather-app:$IMAGE_TAG localhost:5001/weather-app:$IMAGE_TAG
docker tag dice-app:$IMAGE_TAG localhost:5001/dice-app:$IMAGE_TAG
docker tag pod-metadata-app:$IMAGE_TAG localhost:5001/pod-metadata-app:$IMAGE_TAG
docker tag dogs-app:$IMAGE_TAG localhost:5001/dogs-app:$IMAGE_TAG

docker push localhost:5001/weather-app:$IMAGE_TAG
docker push localhost:5001/dice-app:$IMAGE_TAG
docker push localhost:5001/pod-metadata-app:$IMAGE_TAG
docker push localhost:5001/dogs-app:$IMAGE_TAG
