#!/bin/bash

IMAGE_TAG="latest"

docker build -it weather-app:$IMAGE_TAG ./apps/weather
docker build -it dice-app:$IMAGE_TAG ./apps/dice
