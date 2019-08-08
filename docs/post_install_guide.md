# Post Installation Guide

After the installation, you are good to go to install Kubernetes or OpenShift on your provisioned infrastructure.
You can find the IP addresses and DNS names of your infrastructure using the Azure Portal.

## Configuring DNS

If you want to use public DNS entries and you own the domain you used for your cluster (which is highly recommended),
you will have to create an NS record for your cluster domain pointing to Azure's nameservers.
Be advised in order for most Kubernetes and OpenShift provisioners to work probably, public DNS is a prerequisite.
You can find the nameservers that correspond to the Azure domain zone that was provisioned be FormKube in the domain 
zone on the Azure Portal.
For more information about DNS, take a look at the [DNS Architecture and Configuration](dns.md).

## AKS Provider-Specific Tasks

### Configuring Loadbalancer CNAME

When deploying the cluster using the AKS provider, you will need to deploy the loadbalancer on you own using the Kubernetes
Service Type *Loadbalancer*. Usually, you will only use this Service Type once for your Ingresscontroller. After the 
Loadbalancer was created, you will need to change the A-Record for the Loadbalancer inside the created DNS Zone manually
to the IP address of the loadbalancer that was created by Kubernetes. All of the other records are CNAMEs based onto 
that A-Record and do not need to be changed.

## Azure Provider-Specific Tasks

### Placing Private ssh keys on the Bastions

As already mentioned in the [*Bootstrapping Prerequisites*](prerequisites.md), FormKube does not handle your ssh keys
for you. Therefore, after initial bootstrapping, it is required that you place the private ssh keys that correspond to
the public ssh keys, that you passed using the variables *bastions_pub_key_controller_path*,
*masters_pub_key_controller_path*, *computenodes_pub_key_controller_path* and *infranodes_pub_key_controller_path*, on
the bastion host. You can do this manually, via sth. like Ansible or simple use a shellscript calling 
[scp](https://linux.die.net/man/1/scp).

### Additional Post-Installation Tasks

It may occur that in current releases, additional manual post-installation tasks are required.
You can find them in [Known Issues](./known_issues.mdn).

### Installing Kubernetes

There are many ways to install Kubernetes today -  
[naked kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/),
[Rancher's rke](https://rancher.com/docs/rke/latest/en/), and many more. Most of these tools that do not include
the provisioning of the needed infrastructure are compatible with FormKube.

If you want a recommendation of a tool to bootstrap Kubernetes on top of FormKube infrastructure, I would point you to 
the guys of [kubespray](https://github.com/kubernetes-sigs/kubespray), who do an excellent job of implementing everything
needed to install Kubernetes using Ansible. You can find an exemplary kubespray inventory configuration in the sample
cluster configurations of FormKube.

In case you chose to go for kubespray, there are two pitfalls to look out for:
1. Recommended IP configuration: IPv4 and IPv6 enabled on kernel-level, IPv4- and IPv6-forwarding enabled on kernel-level.
1. When kubespray comes to the task *Initialize First Master*, it might be possible that the Azure Loadbalancer that was
created by FormKube does not pick up healthy Kubernets-API-Server Backends in the time given by kubespray. This can be
worked-around by changing **anything** in the Loadbalancing rule in the Azure Portal (i.e. the port) and then switching
it back to the correct configuration. This workaround will re-trigger the Azure Loadbalancer to look for healthy backends.

### Installing OpenShift

When it comes to OpenShift, the recommendation is similar - 
[openshift-ansible](https://github.com/openshift/openshift-ansible) implements ansible roles for the whole installation
of OpenShift. You can also see an exemplary openshift-ansible inventory configuration in the sample cluster
configuration of FormKube.



# Authors
1. [ksandermann](https://github.com/ksandermann)