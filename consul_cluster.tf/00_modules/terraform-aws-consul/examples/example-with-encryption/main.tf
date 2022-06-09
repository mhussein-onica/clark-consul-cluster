# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A CONSUL CLUSTER IN AWS
# These templates show an example of how to use the consul-cluster module to deploy Consul in AWS. We deploy two Auto
# Scaling Groups (ASGs): one with a small number of Consul server nodes and one with a larger number of Consul client
# nodes. Note that these templates assume that the AMI you provide via the ami_id input variable is built from
# the examples/example-with-encryption/packer/consul-with-certs.json Packer template.
# ---------------------------------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE CONSUL SERVER NODES
# ---------------------------------------------------------------------------------------------------------------------

module "consul_servers" {

  source = "../../modules/consul-cluster"

  cluster_name  = "${var.cluster_name}-server"
  cluster_size  = var.num_servers
  instance_type = var.consul_instance_type
  associate_public_ip_address = var.associate_public_ip_address
  

  # The EC2 Instances will use these tags to automatically discover each other and form a cluster
  cluster_tag_key   = var.cluster_tag_key
  cluster_tag_value = var.cluster_name

  ami_id = var.ami_id
  user_data = templatefile("${path.module}/user-data-server.sh", {
    cluster_tag_key          = var.cluster_tag_key
    cluster_tag_value        = var.cluster_name
    enable_gossip_encryption = var.enable_gossip_encryption
    gossip_encryption_key    = var.gossip_encryption_key
    enable_rpc_encryption    = var.enable_rpc_encryption
    ca_path                  = var.ca_path
    cert_file_path           = var.cert_file_path
    key_file_path            = var.key_file_path
  })

  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids

  allowed_ssh_cidr_blocks = var.allowed_ssh_cidr_blocks

  allowed_inbound_cidr_blocks = var.allowed_inbound_cidr_blocks
  ssh_key_name                = var.ssh_key_name

  tags = [
    {
      key                 = "Environment"
      value               = "development"
      propagate_at_launch = true
    }
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE CONSUL CLIENT NODES
# Note that you do not have to use the consul-cluster module to deploy your clients. We do so simply because it
# provides a convenient way to deploy an Auto Scaling Group with the necessary IAM and security group permissions for
# Consul, but feel free to deploy those clients however you choose (e.g. a single EC2 Instance, a Docker cluster, etc).
# ---------------------------------------------------------------------------------------------------------------------

module "consul_clients" {
  
  source = "../../modules/consul-cluster"

  cluster_name  = "${var.cluster_name}-client"
  cluster_size  = var.num_clients
  instance_type = var.consul_instance_type
  associate_public_ip_address = var.associate_public_ip_address

  cluster_tag_key   = "consul-clients"
  cluster_tag_value = var.cluster_name

  ami_id = var.ami_id
  user_data = templatefile("${path.module}/user-data-client.sh", {
    cluster_tag_key          = var.cluster_tag_key
    cluster_tag_value        = var.cluster_name
    enable_gossip_encryption = var.enable_gossip_encryption
    gossip_encryption_key    = var.gossip_encryption_key
    enable_rpc_encryption    = var.enable_rpc_encryption
    ca_path                  = var.ca_path
    cert_file_path           = var.cert_file_path
    key_file_path            = var.key_file_path
  })
  
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids

  allowed_ssh_cidr_blocks = var.allowed_ssh_cidr_blocks

  allowed_inbound_cidr_blocks = var.allowed_inbound_cidr_blocks
  ssh_key_name                = var.ssh_key_name
}

data "aws_region" "current" {
}
