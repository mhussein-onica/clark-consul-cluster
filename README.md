# clark-devops-challange
create a consul cluster.

# Prerequisites to deploy this module.
# To build the Consul AMI:

1. `git clone` this repo to your computer.
1. Install [Packer](https://www.packer.io/). version>=[1.5.4] as the minimum version.
1. Configure your AWS credentials using one of the [options supported by the AWS
   SDK](http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html). Usually, the easiest option is to
   set the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.

1. cd to [/clark-devops-challange/consul_cluster.tf/00_modules/terraform-aws-consul/examples/consul-ami/consul.json]

1. Update the `variables` section of the `consul.json` Packer template to configure the AWS region, Consul version, and
   Dnsmasq version you wish to use. If you want to install Consul Enterprise, skip the version variable and instead set 
   the `download_url` to the full url that points to the consul enterprise zipped package.

1. make sure to change the following variables to match the resources in your account ["vpc_id", "subnet_id", "security_group_id"]
1. Run `packer build -debug -only amazon-linux-2-ami consul.json`.

When the build finishes, it will output the IDs of the new AMIs.
# To deploy the cluster using one of these custom AMIs built by packer:

1. Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli). version>= [0.12.26] as the minimum version.
1. cd to [/clark-devops-challange/consul_cluster.tf/consul-cluster-clark-dev]
1. Update the `variables` section of the `clark-dev.tfvars`
1. Run: `terraform init`
1. Run: `terraform plan    -var-file="clark-dev.tfvars"` to do a plan.
1. Run: `terraform apply   -var-file="clark-dev.tfvars"` to apply.
1. Run: `terraform destroy -var-file="clark-dev.tfvars"` to destroy.

1. This will deploy a consul cluster with at least 3 instances configured as a [server mode], 

# To create a cluster with server, client nodes do the following:

1. cd `/clark-devops-challange/consul_cluster.tf/00_modules/terraform-aws-consul/examples/example-with-encryption`
1. create tls certificate for your domain [clark-devops-challange/consul_cluster.tf/00_modules/terraform-aws-consul/modules/private-tls-cert]
1. copy the generated cert files to [/clark-devops-challange/consul_cluster.tf/00_modules/terraform-aws-consul/examples/example-with-encryption/packer]
1. build the custom ami using packer [/clark-devops-challange/consul_cluster.tf/00_modules/terraform-aws-consul/examples/example-with-encryption/packer/consul-with-certs.json]
1. cd to [/consul_cluster.tf/00_modules/terraform-aws-consul/examples/example-with-encryption]
1. Update the `variables` section of the `clark-dev.tfvars`
1. Run: `terraform init`
1. Run: `terraform plan    -var-file="clark-dev.tfvars"` to do a plan.
1. Run: `terraform apply   -var-file="clark-dev.tfvars"` to apply.
1. Run: `terraform destroy -var-file="clark-dev.tfvars"` to destroy.

# solution architect:

1. check the graph [/clark-devops-challange/screenshoots/Consul-design.PNG]

# Hints:

1. For tetsing purposes [I didn't create Bastion Host servers and instaed accessed the servers using SSM].

# Describe the ongoing maintenance tasks that you will carry out on a regular basis

1. creating a pipeline to to have the solution fully automated.
1. thinking of having the consul cluster to be deployed on K8s cluster instead of standalone EC2s.
1. vpce endpoint with ssm to the servers hosted in the privated subnet if is SSM is sufficient without needing the Bastion host.


# testing:

1. run [consul members -http-addr=${consul-server-private-ip}:8500] ---> [consul members -http-addr=172.31.15.125:8500].

You can also try inserting a value:
> consul kv put -http-addr=11.22.33.44:8500 clark bar

Success! Data written to: clark
And reading that value back:
> consul kv get -http-addr=11.22.33.44:8500 clark

bar


Finally, you can try opening up the Consul UI in your browser at the URL http://172.31.15.125:8500/ui/.



# cost:














































# References: More info: https://github.com/hashicorp/terraform-aws-consul/