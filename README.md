# k8s-local-tilt
Show how to incorporate [Tilt](https://tilt.dev/) with [minikube](https://minikube.sigs.k8s.io/docs/) to quickly spin up applications on a local Kubernetes cluster with [ArgoCD](https://argo-cd.readthedocs.io/en/stable/). 

## Prerequisites 
Though the links below are more specific for Mac, the Linux installation docs are in similar spaces.
* Docker Desktop: https://docs.docker.com/desktop/install/mac-install/
* Minikube installed: https://minikube.sigs.k8s.io/docs/start/
* Tilt installed: https://docs.tilt.dev/install.html#homebrew-macos-or-linux
* Kubectl CLI installed: https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/
* Kustomize installed: https://kubectl.docs.kubernetes.io/installation/kustomize/homebrew/

## Getting Started
After all the [Prerequisites](#prerequisites) are installed, users can begin by starting up minikube!
```
> minikube start --cpus 4 --memory 16384
```
The above command will start up a Kubernetes cluster on your local docker with 4 CPUs and 16GB of memory. If your machine does not have these resources, you can change them to be more accomodating.
> you may need to update your docker desktop [resource allocation](https://docs.docker.com/desktop/settings/mac/#resources)

## Lab: Fix Broken App
With minikube running, you should be able to run the below command (from the root of this repository):
```
> tilt up -- --with all
```
This will automatically install ArgoCD and make ArgoCD manage itself...pretty neat! Following the instructions on your terminal, you can view the Tilt dashboard by pressing the spacebar:
```
> tilt up
Tilt started on http://localhost:10350/
v0.30.10, built 2022-10-25

(space) to open the browser
(s) to stream logs (--stream=true)
(t) to open legacy terminal mode (--legacy=true)
(ctrl-c) to exit
Opening browser: http://localhost:10350/
```
![](.bin/tilt-up-default.png?raw=true)

## The Problem
You will recognize that upon [logging into ArgoCD](#logging-in-to-argocd), the dashboard page will show the `broken-app` in an `Unknown` status. The goal of this lab is for you to determine the root cause of this issue and resolve it. 
![](.bin/argo-landing-broken.png?raw=true)

## Logging into ArgoCD
With ArgoCD being installed by default when you `tilt up`, the UI is already being forwarded to https://localhost:8080. The credentials are below:
* username: admin
* password: `<uniq per install...see image below>`

![](.bin/argo-cd-password.png?raw=true)
