# Considered Features for future releases

1. output dns servers with instructions at the end
-> https://www.terraform.io/docs/provisioners/index.html
   
1. place firewall in front of the bastion + alb
   
1. support tfstate in remote backend
-> https://www.terraform.io/docs/backends/types/azurerm.html
   
1. consider enabling os disk caching as option
   
1. template ips to kubespray and openshift-ansible inventory template

1. Move A-records to private dns zone once officially released by Azure (private dns zones are in preview state)

1. Write own dockerimage for FormKube (instead of using cloud-toolbox)

# Authors
1. [ksandermann](https://github.com/ksandermann)