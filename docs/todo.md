# TODO

* [ ] create issues on terraform for issue [#1](https://github.com/ksandermann/formkube/issues/1)

* [ ] create issues on terraform for issue [#2](https://github.com/ksandermann/formkube/issues/2)

* [ ] create issues on terraform for issue [#6](https://github.com/ksandermann/formkube/issues/6)

* [ ] refactoring: move tf plan to separate script,
always source this in apply.sh and
source this in destroy.sh if plan file is not present.
Need to be aware of development mode features

# DONE 

This list is just kept for development documentation purposes.
All these issues have been solved prior to the first Open Source release

* [X] Resource group not ready when second module is invoked -> error
-> solved by outputting resource_group_name and referencing output variable in other modules

* [x] create security roles for application security groups rather than CIDRs

* [x] split .tf files per module in type groups

* [x] split vars into mandatory and (optional with default)

* [x] make everything configurable (cidr etc.)

* [x] var descriptions

* [x] refactor resource var names

* [x] create nodes

* [x] split compute and infra nodes

* [x] make plural/singular on node(s), master(s)

* [x] count
examples:
https://github.com/coreos/tectonic-installer/blob/1.9.6-tectonic.3/modules/azure/vnet/nic-master.tf
https://github.com/coreos/tectonic-installer/blob/1.9.6-tectonic.3/modules/azure/vnet/outputs.tf
https://github.com/Azure/terraform-azurerm-network-security-group/blob/master/main.tf

* [x] DNS

* [x] multiple bastions + refactor vars to plural

* [x] separate bastion resources from module

* [x] static IPs for ansible ? -> YES 
https://www.terraform.io/docs/configuration/functions/cidrhost.html

* [x] ensure nic1 is bound to master1 etc. 

* [x] tags

* [x] vm scale set -> use availibility zones instead
-> https://social.technet.microsoft.com/wiki/contents/articles/51828.azure-vms-availability-sets-and-availability-zones.aspx

* [x] environment as tag

* [x] count breaks re-run at the moment
-> upgraded to terraform 0.12.4, working now

* [x] refactor to HCL2 expressions

* [x] availibility zones per region? -> document which regions are supported
av. zone docs:
https://social.technet.microsoft.com/wiki/contents/articles/51828.azure-vms-availability-sets-and-availability-zones.aspx
https://blogs.msdn.microsoft.com/igorpag/2018/05/03/azure-availability-zones-quick-tour-and-guide/
https://msdnshared.blob.core.windows.net/media/2018/05/3.jpg
https://docs.microsoft.com/en-us/azure/availability-zones/az-overview
https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-standard-public-zone-redundant-cli
https://www.c-sharpcorner.com/article/availability-set-fault-domains-and-update-domains-in-azure-virtual-machie/

* [x] set all vars explicitly

* [x] static IP config won't work if adding new nodes -> start masters with ip 10, compute nodes with ip 100, infra nodes with ip 200

* [x] apply and destroy scripts should call docker run 

* [x] bug: disk RG in caps?
-> known issue

* [x] dont remove rg and vaults on destroy

* [x] backup

* [x] switch to 2 networks instead of 2 subnets
-> not reasonable as subnet are needed for nics anyway

* [x] create Loadbalancer security rules

* [x] only add 1 nic to bastion?
reasons:
SSH to bastion not working when private nic is primary nic
SSH to masters not working when only private nic app sec group is allowed to ssh to masters in net rules

* [x] NAT gateway for node outbound -> Cluster internet access not working
Already automatically working?
https://docs.microsoft.com/de-de/azure/load-balancer/load-balancer-outbound-connections#lb
-> is automatically working when disable_outbound_snat is NOT set true on the loadbalancer rules

* [x] remove default security rules form security_group
-> Blocked all traffic with rule for cluster with prio 110
-> the lower the number, the higher the priority
-> NSG not working for interet routing, put firewall in front
https://stackoverflow.com/questions/41559854/azure-load-balancer-nsg-rules-remove-access-directly
-> fixed, see comments in net sec rules

* [x] local var clusterFQDN in main playbook + pass this everywhere

* [x] script azure login and subscription ID etc. ENV configuration -> Use azure answerfile and > into it in the container tmpfs
1. try to get values from ENV
2. get values from stdin

* [x] refactor comments from # to //

* [x] PER MODULE: fix todos, sort vars and update vars with patterns from conventions above, also fix compute_nodes to computenodes etc.
    * [x] vnet
    * [x] loadbalancer
    * [x] dns -> removed
    * [x] masters
    * [x] nodes
    * [x] bastions
    * [x] essentials
    * [x] backup
    
* [x] statefile in cluster directory

* [x] test if existing backup in vault (manually created) is kept when applying delete (as vault is not deleted anymore)
-> works, backup is kept with the vault

* [x] known issues to github issues

* [x] terraform issue for:
KNOWNISSUE - setting tags here results in terraform always changing as these tags are not really created by terraform
and can also not be added to backup targets in Azure portal
and can also not be added to backup policies in Azure portal
    
* [x] overthink module separation
-> dns module removed, backup migrated to separate module

* [x] netzwerk architektur bild

* [x] tectonic comparison

* [x] only remove rg and vaults from state on destroy.sh when env development_mode is not set -> document that this will fail if backup is present.
-> dont prompt for "yes" on terraform destroy when in dev mode -> document this

* [x] output that master disk was not deleted if var was set - get this value from terraform out

* [x] Remove bash stdout where reasonable (docker pull -> better "update FormKube" etc. )
    
* [x] test if backup actually works when NOT in dev mode (look in backup items after apply)

* [x] Generate ssh keys automatically by azure and place them in azure key store
->https://github.com/ksandermann/formkube/issues/7

* [x] ssh access not working when not setting admin pw AND disabling password authentication
-> admin_password has to be set to ""

* [x] search for todos in code

* [x] DEV + PRD example inventory INCLUDING kubespray + openshift-ansible okd inventory
    * [x] dev config
    * [x] dev okd
    * [x] dev kubespray
    * [x] prd config
    * [x] prd okd
    * [x] prd kubespray
    * [x] docs + howto example
    
* [x] document
    * [x] destroy excluding rg and vaults
    * [x] cluster config folder MUST be named like clusterFQDN
    * [x] ssh keys are placed inside cluster config after initial bootstrap
    * [x] supported regions

# Authors
1. [ksandermann](https://github.com/ksandermann)