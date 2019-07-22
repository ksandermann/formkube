# Understanding FormKube's Naming Conventions

* The following names refer to the following subset of resources:
    1. *Masters* refers to the master nodes.
    1. *Computenodes* refers to the nodes running application pods.
    1. *Infranodes* refers to the nodes running infrastructure pods, such as ingress controller, monitoring pods, tiller etc.
    1. *Nodes* refers to the superset of computenodes and infranodes.
    1. *Cluster* refers to the superset off all masters and nodes (excluding the bastion).
    1. *Bastions* refers to the bastion hosts.
    1. *Controller Host* refers to the machine running terraform to apply all the resources.
    1. *Platform* refers to the superset of all resources.

For information on how to implement the separation of computenodes and infranodes with vanilla Kubernetes, please refer
to the official documentation of the
[PodNodeSelector admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#podnodeselector)
and 
[this stackoverflow thread](https://stackoverflow.com/questions/52487333/how-to-assign-a-namespace-to-certain-nodes).

# Authors
1. [ksandermann](https://github.com/ksandermann)