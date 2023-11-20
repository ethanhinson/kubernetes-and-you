# Kind Cluster Setup
This is a simple Kind cluster setup for local development. It is based on the [official documentation](https://kind.sigs.k8s.io/docs/user/quick-start/).
## Prerequisites
You should have installed kubectl, Docker, and golang 1.20.
## Scenario
Imagine you are working an organization with multiple teams. Each team uses its own language. But since we are working in a services oriented environment. It is important that our apps be able to communicate with each other.

In the `./apps` folder you will find three different services, written in 3 different languages. Each service has its own Dockerfile to build the image.

## Setup
To set up the example run the bash commands in `./bin` in the specified order.

```bash
# This script sets up the kind cluster
bash ./bin/1.install-kind.sh
# This script installs helm
bash ./bin/2.install-helm.sh
# This script installs ingress-nginx
bash ./bin/3.install-ingress-nginx.sh
# This script builds and pushes the images to the registry
# You'd repeat this step and the following step
# each time you make a change to the code
bash ./bin/4.build-push.sh
# This script deploys the apps in the cluster
# you run this script when you want to roll
# out changes.
bash ./bin/5.deploy-k8s.yaml
```

### Deploying the apps

Steps 4 and 5 represent the steps of deploying containers into the cluster. You can repeat these steps each time you make a change to the code.
The workflow is as follows:

```
+--------------+       +------------------+       +------------------+       +------------------+
|              |       |                  |       |                  |       |                  |
|   Coding     | ----> |  Build Image     | ----> |  Push to Registry|       |  Kubernetes Pod  |
|              |       |                  |       |                  |       |                  |
+--------------+       +------------------+       +------------------+       +------------------+
                                                       |                              ^
                                                       |                              |
                                                       +------------------------------+
                                                      Pull Image & Update Pod

```