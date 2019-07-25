# Comparison to other tools

As FormKube does **not** bootstrap Kubernetes or OpenShift itself, the most known product to compare it to would be
[tectonic-installer](https://github.com/coreos/tectonic-installer). As 
[this blogpost](https://coreos.com/blog/coreos-tech-to-combine-with-red-hat-openshift) states, tectonic-installer
is currently being merged with Red Hat's OpenShift into [openshift-installer](https://github.com/openshift/installer).
As the documentation states, tectonic-installer will not get any more features. Also, in the current state 
openshift-installer does not support Azure (yet).
Therefore, it is reasonable to compare FormKube with both of these tools.
For additional information on how to install Kubernetes or OpenShift on the infrastructure provisioned by FormKube,
please see the [Post Installation Guide](post_install_guide.md).


| Feature                         	|  FormKube  	            | TectonicInstaller@Azure 	| OpenShift Installer@Azure 	|
|-----------------------------------|---------------------------|---------------------------|-------------------------------|
| Kubernetes Support              	|     Yes    	            |           Yes           	| Azure not supported (yet) 	|
| OpenShift Support               	|     Yes    	            |            No           	| Azure not supported (yet) 	|
| High Availability               	| multi-rack (one region) 	|  multi-rack (one region)  | Azure not supported (yet) 	|
| Automated Infrastructure Backup 	|     Yes    	            |            No           	| Azure not supported (yet) 	|


# Authors
1. [ksandermann](https://github.com/ksandermann)