# Kind Cluster Setup
This is a simple Kind cluster setup for local development. It is based on the [official documentation](https://kind.sigs.k8s.io/docs/user/quick-start/).
## Prerequisites
You should have installed kubectl, Docker, and golang 1.20.
## Setup
To set up the cluster, run the following command:
```bash
bin/install.sh
```
## Scenario
Imagine you are working an organization with multiple teams. Each team uses its own language. But since we are working in a services oriented environment. It is important that our apps be able to communicate with each other.

In the `./apps` folder you will find three different services, written in 3 different languages. Each service has its own Dockerfile to build the image.
