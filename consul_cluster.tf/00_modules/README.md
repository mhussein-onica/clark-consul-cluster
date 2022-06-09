# Prerequisites to deploy this module.

# Generate Private TLS Cert

To do, go to the following directory /metadata-aws-ct-iac/runway/08_vault.tf/00_modules/terraform-aws-vault/modules/private-tls-cert

1. Open `variables.tf` and fill in the variables that do not have a default and modify the owner (OS username).

1. DO NOT configure Terraform remote state storage for this code. You do NOT want to store the state files as they 
   will contain the private keys for the certificates.

1. Run `terraform apply`. The output will show you the paths to the generated files:

    ```
    Outputs:
    
    ca_public_key_file_path = ca.key.pem
    private_key_file_path = vault.key.pem
    public_key_file_path = vault.crt.pem
    ```
    
1. Delete your local Terraform state:

    ```
    rm -rf terraform.tfstate*
    ```

   The Terraform state will contain the private keys for the certificates, so it's important to clean it up!

1. To inspect a certificate, you can use OpenSSL:

    ```
    openssl x509 -inform pem -noout -text -in vault.crt.pem
    ```

Now that you have your TLS certs.

Generated TLS used for dev,stage accounts, shared with Mani.

# build ami with vault and counsul installed:

To do, go to the following directory `/metadata-aws-ct-iac/runway/08_vault.tf/00_modules/terraform-aws-vault/examples/vault-consul-ami`

1. copy the cert files generated from the `Generate Private TLS Cert` to the following directory `/metadata-aws-ct-iac/runway/08_vault.tf/00_modules/terraform-aws-vault/examples/vault-consul-ami/tls/`

1. cd to `/mnt/d/utd/Metadata/metadata-dev/md-mq-broker/metadata-aws-ct-iac/runway/08_vault.tf/00_modules/terraform-aws-vault/examples/vault-consul-ami`

1. sso to the master ct account

1. jump to the target account usinf assume roles. .sh files on how to assume file sent to Mani

1. Run: `source assumme-metadata-dev.sh`

1. Run: `aws sts get-caller-identity` to make sure that you are in the right account.

1. Run `packer build -debug -only ubuntu20-ami vault-consul-dev.json` or 
       `packer build -debug -only ubuntu20-ami vault-consul-stage.json` .....

* Hint: packer should be installed
* Ami not shared for now, each account dev, stage has its own image.

1. once ami generated, take a note of the new ami id, and use it in the caller.

* Now you should be able to run the module same way we do for the other modules. (runway or native tf)