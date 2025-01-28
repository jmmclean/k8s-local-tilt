if k8s_context() != 'minikube':
    fail("K8s context is not minikube")

allow_k8s_contexts(contexts = ["minikube"])

# load in common utilities
load('.utils/tilt/common.bzl', 'uniq')


config.define_string_list("with")
cfg = config.parse()
w = cfg.get('with', [])

# define groups for --with command
groups = {
    "argo": [
        "argo-rollouts",
        "argo-workflows"
    ],
    "appset": [
        "guestbook"
    ]
}

if 'argo' in w:
    w += groups['argo']
    w.remove('argo')
if 'appset' in w:
    w += groups['appset']
    w.remove('appset')

# include common services that will ALWAYS be included by Tilt
include('./argo-cd/Tiltfile')

w = uniq(w)

# include all services
for k8s_service in w:
    include('./{svc}/Tiltfile'.format(svc=k8s_service))
