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
    "all": [
        "argo-rollouts",
        "argo-workflows",
        "broken-app"
    ],
    "argo": [
        "argo-rollouts",
        "argo-workflows"
    ]
}

if 'argo' in w:
    w = groups['argo']
if 'all' in w:
    w = groups['all']

# include common services that will ALWAYS be included by Tilt
include('./argo-cd/Tiltfile')

w = uniq(w)

# include all services
for k8s_service in w:
    include('./{svc}/Tiltfile'.format(svc=k8s_service))
