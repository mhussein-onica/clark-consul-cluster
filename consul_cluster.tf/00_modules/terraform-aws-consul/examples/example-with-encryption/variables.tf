# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "ami_id" {
  description = "The ID of the AMI to run in the cluster. This should be an AMI built from the Packer template under examples/example-with-encryption/packer/consul-with-certs.json. To keep this example simple, we run the same AMI on both server and client nodes, but in real-world usage, your client nodes would also run your apps. If the default value is used, Terraform will look up the latest AMI build automatically."
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "What to name the Consul cluster and all of its associated resources"
  type        = string
  default     = "consul-example"
}

variable "num_servers" {
  description = "The number of Consul server nodes to deploy. We strongly recommend using 3 or 5."
  type        = number
  default     = 3
}

variable "num_clients" {
  description = "The number of Consul client nodes to deploy. You typically run the Consul client alongside your apps, so set this value to however many Instances make sense for your app code."
  type        = number
  default     = 3
}

variable "cluster_tag_key" {
  description = "The tag the EC2 Instances will look for to automatically discover each other and form a cluster."
  type        = string
  default     = "consul-servers"
}

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Set to an empty string to not associate a Key Pair."
  type        = string
  default     = null
}

variable "spot_price" {
  description = "The maximum hourly price to pay for EC2 Spot Instances."
  type        = string
  default     = null
}

variable "enable_gossip_encryption" {
  description = "Encrypt gossip traffic between nodes. Must also specify encryption key."
  type        = bool
  default     = true
}

variable "enable_rpc_encryption" {
  description = "Encrypt RPC traffic between nodes. Must also specify TLS certificates and keys."
  type        = bool
  default     = true
}

variable "gossip_encryption_key" {
  description = "16 byte cryptographic key to encrypt gossip traffic between nodes. Must set 'enable_gossip_encryption' to true for this to take effect. WARNING: Setting the encryption key here means it will be stored in plain text. We're doing this here to keep the example simple, but in production you should inject it more securely, e.g. retrieving it from KMS."
  type        = string
  default     = ""
}

variable "ca_path" {
  description = "Path to the directory of CA files used to verify outgoing connections."
  type        = string
  default     = "/opt/consul/tls/ca"
}

variable "cert_file_path" {
  description = "Path to the certificate file used to verify incoming connections."
  type        = string
  default     = "/opt/consul/tls/consul.crt.pem"
}

variable "key_file_path" {
  description = "Path to the certificate key used to verify incoming connections."
  type        = string
  default     = "/opt/consul/tls/consul.key.pem"
}

variable "vpc_id" {
  description = "the VPC to spin up resources within."
  type        = string
}

variable "subnet_ids" {
  description = "private subnets to be used with ASGs"
  type        = list(string)
}

variable "allowed_ssh_cidr_blocks" {
  description = "allowed_ssh_cidr_blocks"
  type        = list(string)
}

variable "allowed_inbound_cidr_blocks" {
  description = "allowed_inbound_cidr_blocks"
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "If set to true, associate a public IP address with each EC2 Instance in the cluster."
  type        = bool
  default     = false
}

variable "availability_zones" {
  description = "The availability zones into which the EC2 Instances should be deployed. We recommend one availability zone per node in the cluster_size variable. At least one of var.subnet_ids or var.availability_zones must be non-empty."
  type        = list(string)
  default     = null
}

variable "consul_instance_type" {
  description = "The type of EC2 Instance to run in the Consul ASG"
  type        = string
  default     = "t2.nano"
}