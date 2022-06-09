#consul
consul_instance_type = "t3.small"
aws_region = "us-east-1"
cluster_tag_key = "consul-cluster-clark"
cluster_name = "consul-cluster-clark"
num_servers  = 3
num_clients  = 3
ami_id = "ami-039fae9baf4bd3319" #Custom AMI created using packer with Consul, Dnmasq installed.
vpc_id = "vpc-03a1cedae19c84d48" #clark-dev-vpc
subnet_ids = ["subnet-04b7dfdf666f50ec0","subnet-00e6e7a65c4c6c95c","subnet-0531329e90b30b9a7"] #private-subnets-recommended
allowed_ssh_cidr_blocks = ["0.0.0.0/0"] #just for testing purposes ["172.31.0.0/16"] #clark-dev-vpc-cidr
allowed_inbound_cidr_blocks = ["0.0.0.0/0"] #just for testing purposes ["172.31.0.0/16"] #clark-dev-vpc-cidr
ssh_key_name = "consul-kp"
associate_public_ip_address = true #best practise to be in private subnets just for testing purposes
