# DNS Architecture and Configuration

It is strongly advised to only use a domain for you cluster that you own.

FormKube will create an Azure DNS Zone containing A-Records and CNAMEs for your cluster using the pattern
*.{cluster_name}.{cluster_domain}, for example mycluster.example.com.

After bootstrapping your infrastructure with FormKube, you will need to create a NS record using your domain provider.
The NS record needs to point to the appropriate four Azure DNS servers (which will vary on each bootstrap).
You can find the DNS servers that responsible for your Azure DNS Zone in the Azure Portal under the appropriate DNS zone.


## Exemplary DNS Configuration

The following tables show an exemplary setup of the created DNS records when bootstrapping a cluster with one bastion
host, one master, one computenode and one infranode using {cluster_name=mycluster} and {cluster_domain}=example.com

### Created A-Records

| Source                             | Destination               |
|------------------------------------|---------------------------|
| bastion1.mycluster.example.com     | 10.0.2.10                 |
| master1.mycluster.example.com      | 10.0.1.10                 |
| computenode1.mycluster.example.com | 10.0.1.100                |
| infranode1.mycluster.example.com   | 10.0.1.200                |
| alb.mycluster.example.com          | 40.67.206.157 (exemplary) |

As Azure private DNS zones are currently still in preview state, A-Records to private IP-Addresses will be created by
FormKube. There is some discussion ongoing about the security of public DNS entries pointing to private IP-spaces, as
FormKube is bootstrapping infrastructure running on a Public Cloud anyway, and it is strongly advised to only use a
domain you really own, this is not considered unsafe at this point. If you want to see more information, 
there is an excellent post about the topic [here](https://serverfault.com/a/4463).

### Created CNAMEs

| Source                                                             	| Destination                	|
|-----------------------------------------------------------------------|-------------------------------|
| apps.mycluster.example.com                                         	| alb.mycluster.example.com  	|
| *.apps.mycluster.example.com                                       	| apps.mycluster.example.com 	|
| api.mycluster.example.com                                          	| alb.mycluster.example.com  	|
| cluster.mycluster.example.com                                      	| alb.mycluster.example.com  	|
| logs.mycluster.example.com                                         	| alb.mycluster.example.com  	|
| elastic.mycluster.example.com                                      	| alb.mycluster.example.com  	|
| kibana.mycluster.example.com                                       	| alb.mycluster.example.com  	|
| hawkular-metrics.mycluster.example.com                             	| alb.mycluster.example.com  	|
| registry.mycluster.example.com                                     	| alb.mycluster.example.com  	|
| dashboard.mycluster.example.com                                    	| alb.mycluster.example.com  	|
| {loadbalancer_dns_additional_cnames}.mycluster.example.com         	| alb.mycluster.example.com  	|
| ops.mycluster.example.com                                          	| alb.mycluster.example.com  	|
| kibana.ops.mycluster.example.com                                   	| ops.mycluster.example.com  	|
| elastic.ops.mycluster.example.com                                  	| ops.mycluster.example.com  	|
| grafana.ops.mycluster.example.com                                  	| ops.mycluster.example.com  	|
| prometheus.ops.mycluster.example.com                               	| ops.mycluster.example.com  	|
| {loadbalancer_dns_ops_additional_cnames}.ops.mycluster.example.com 	| ops.mycluster.example.com  	|


# Authors
1. [ksandermann](https://github.com/ksandermann)