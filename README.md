# Kind Cluster Setup
This is a simple Kind cluster setup for local development. It is based on the [official documentation](https://kind.sigs.k8s.io/docs/user/quick-start/).
## Prerequisites
You should have installed kubectl, Docker, and golang 1.20.

### Without installing Go
Go is only used to install `kind` in a platform-agnostic way. If you would like to skip this prerequisite, you can install `kind` manually by following the instructions [here](https://kind.sigs.k8s.io/docs/user/quick-start/#installation).

If you manually install `kind` you still must run the `1.install-kind.sh` script to create the cluster.

## Scenario
Imagine you are working an organization with multiple teams. Each team uses its own language. But since we are working in a services oriented environment. It is important that our apps be able to communicate with each other.

In the `./apps` folder you will find two different services, written in two different languages. Each service has its own Dockerfile to build the image.

## What we'll build

### Cluster topology
We have a 3 node cluster. 1 node is dedicated to running the control plane, and we'll have worker nodes to run our apps.

```
+---------------------+
| Kubernetes Cluster  |
+---------------------+
|                     |
| +-----------------+ |
| | Control Plane   | |
| | Node            | |
| +-----------------+ |
|                     |
| +-----------------+ |       +-----------------+
| | Worker Node 1   | | <---- | Deployments     |
| +-----------------+ |       +-----------------+
|                     |       
| +-----------------+ |       +-----------------+
| | Worker Node 2   | | <---- | Deployments     |
| +-----------------+ |       +-----------------+
|                     |
+---------------------+
```

### Application topology
We'll create 2 separate apps and create ingress, load balancing, and horizontal scaling. The following diagram depicts the architecture of the system we'll build.

#### Keep in mind
- That the apps are running in the same namespace, but they are completely isolated from each other.
- Even though the Pods are part of one deployment. The containers within the pod could be running on either worker node

```
               +-----------------+
               |                 |
               | Ingress         |
               | Controller      |
               |                 |
               +--------+--------+
                        |
         +--------------+-------------+
         |                            |
+--------v--------+         +---------v-------+
|                 |         |                 |
| Service Ingress |         | Service Ingress |
| "weather"       |         | "dice"          |
|                 |         |                 |
+--------+--------+         +---------+-------+
         |                            |
         |                            |
+--------v--------+         +---------v-------+
|                 |         |                 |
| Deployment      |         | Deployment      |
| "weather-app"   |         | "dice-app"      |
|                 |         |                 |
| +-------------+ |         | +-------------+ |
| | Pod 1       | |         | | Pod 1       | |
| | Container 1 | |         | | Container 1 | |
| +-------------+ |         | +-------------+ |
| +-------------+ |         | +-------------+ |
| | Pod 2       | |         | | Pod 2       | |
| | Container 1 | |         | | Container 1 | |
| +-------------+ |         | +-------------+ |
| +-------------+ |         +-----------------+
| +-------------+ |         
| | Pod 3       | |         
| | Container 1 | |         
| +-------------+ |         
+-----------------+         
```

## Setup[office.yaml](..%2F..%2FDownloads%2Foffice.yaml)
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

## Testing the apps

To test the apps you can use the following commands:

```bash
# Note the hostnames in the ingress.yaml file weather.test and dice.test respectively
# Add them to your hosts file in /etc/hosts
echo "127.0.0.1 weather.test" | sudo tee -a /etc/hosts > /dev/null
echo "127.0.0.1 dice.test" | sudo tee -a /etc/hosts > /dev/null

curl dice.test:8080/roll-dice
# Output {"roll":4} - you could also visit the url in your browser
curl http://weather.test:8080/WeatherForecast
# [{"date":"2023-11-22T00:31:38.874849+00:00","temperatureC":-13,"temperatureF":9,"summary":"Balmy"},{"date":"2023-11-23T00:31:38.874939+00:00","temperatureC":11,"temperatureF":51,"summary":"Bracing"},{"date":"2023-11-24T00:31:38.8749399+00:00","temperatureC":25,"temperatureF":76,"summary":"Mild"},{"date":"2023-11-25T00:31:38.8749401+00:00","temperatureC":31,"temperatureF":87,"summary":"Freezing"},{"date":"2023-11-26T00:31:38.8749403+00:00","temperatureC":32,"temperatureF":89,"summary":"Scorching"}]
```

## Inspecting the resources in the namespace

When working with Kubernetes, `kubectl` is an essential tool for managing and inspecting resources. Here are some common `kubectl` commands you might use to inspect what we've deployed in the namespace: `your-app`.

### Get Information About the Namespace

To get basic information about your namespace:

```bash
kubectl get namespace your-app
```

### List All Resources in the Namespace
To list all resources in your-app:

```bash
kubectl get all --namespace your-app
```

### View Pods in the Namespace
To list all pods in your-app:

```bash
kubectl get pods --namespace your-app
```
### Accessing Logs of a Pod
To access logs of a specific pod (replace pod-name with the actual pod name):

```bash
kubectl logs pod-name --namespace your-app
```

### Executing Commands in a Pod
To execute a command in a pod (replace pod-name with the actual pod name and command with your command):
```bash
kubectl exec -it pod-name --namespace your-app -- command
```