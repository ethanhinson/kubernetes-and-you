#!/bin/bash
# https://kind.sigs.k8s.io/docs/user/quick-start/
go install sigs.k8s.io/kind@v0.20.0

# Make sure to include your Go bin directory in your PATH
export PATH="$PATH:$(go env GOPATH)/bin"

kind create cluster --name kind