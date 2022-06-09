#consul
region = "us-east-1"
consul_cluster_size = 3
consul_instance_type = "t3.small"
consul_cluster_tag_key = "consul-servers-clark"
consul_cluster_name = "consul-cluster-clark"
ami_id = "ami-039fae9baf4bd3319"  #Custom AMI created using packer with Consul, Dnmasq installed.
vpc_id = "vpc-03a1cedae19c84d48" #"clark-dev-vpc
subnet_ids = ["subnet-04b7dfdf666f50ec0","subnet-00e6e7a65c4c6c95c","subnet-0531329e90b30b9a7"] #private-subnets
availability_zones = ["us-east-1a","us-east-1b", "us-east-1d"] 
allowed_ssh_cidr_blocks = ["172.31.0.0/16"] #clark-dev-vpc
allowed_inbound_cidr_blocks = ["172.31.0.0/16"] #clark-dev-vpc
ssh_key_name = "consul-kp"
associate_public_ip_address = true
