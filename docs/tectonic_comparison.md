# Comparison to other tools

As FormKube does **not** bootstrap Kubernetes or OpenShift itself, the most known product to compare it to would be
[tectonic-installer](https://github.com/coreos/tectonic-installer). As 
[this blogpost](https://coreos.com/blog/coreos-tech-to-combine-with-red-hat-openshift) states, tectonic is currently 
being merged with Red Hat's OpenShift into [openshift-installer](https://github.com/openshift/installer).
Therefore, it is reasonable to compare FormKube with both of these tools.
For additional information on how to install Kubernetes or OpenShift on the infrastructure provisioned by FormKube,
please see the [Post Installation Guide](post_install_guide.md).


| Feature                         	|  FormKube  	| TectonicInstaller@Azure 	| OpenShift Installer@Azure 	|
|-----------------------------------|---------------|---------------------------|-------------------------------|
| Kubernetes Support              	|     Yes    	|           Yes           	| Azure not supported (yet) 	|
| OpenShift Support               	|     Yes    	|            No           	| Azure not supported (yet) 	|
| High Availability               	| multi-zone 	|  multi-rack (one zone)  	| Azure not supported (yet) 	|
| Automated Infrastructure Backup 	|     Yes    	|            No           	| Azure not supported (yet) 	|


# Authors
1. [ksandermann](https://github.com/ksandermann)