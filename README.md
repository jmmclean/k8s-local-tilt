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

With minikube running, you should be able to run the below command (from the root of this repository):
```
> tilt up
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

### Logging in to ArgoCD
With ArgoCD being installed by default when you `tilt up`, the UI is already being forwarded to https://localhost:8080. The credentials are below:
* username: admin
* password: `<uniq per install...see image below>`

![](.bin/argo-cd-password.png?raw=true)

## Adding More Applications
By default, this repository contains [argo-rollouts](https://argoproj.github.io/argo-rollouts/) and [argo-workflows](https://argoproj.github.io/argo-workflows/), however they are not installed by default. We can easily add them by running the below command:
```
> tilt up -- --with argo
```
![](.bin/tilt-up-argo.png?raw=true)

[After logging into Argo](#logging-in-to-argocd), users should see a total of 3 applications being managed:
* argo-cd
* argo-workflows
* argo-rollouts
To mutate any of these deployment configurations, users will want to test their changes my modifying the `application.yml` to have a `targetRevision` that is equal to your current branch, otherwise it will be looking at main. ([ArgoCD Application manifest](argo-cd/local/minikube/application.yml))
> Be sure to push up your local branch!

![](.bin/argo-auth-landing.png?raw=true)


Since Tilt is orchestrating all this work, users can view the source by navigating to the [tiltfile](Tiltfile). Specifically we can find the below code, which will automatically add some other applications via the group `argo`.
```python
# define groups for --with command
groups = {
    "argo": [
        "argo-rollouts",
        "argo-workflows"
    ]
}
```
