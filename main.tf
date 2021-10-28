# Version requirements

terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = ">=4.41.0"
    }
  }
  required_version = ">= 1.0.0"
}

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = var.label_prefix

  # vcn parameters
  create_internet_gateway = var.create_internet_gateway
  create_nat_gateway      = var.create_nat_gateway
  create_service_gateway  = var.create_service_gateway
  create_drg               = var.create_drg
  drg_display_name         = var.drg_display_name
  freeform_tags            = var.freeform_tags
  vcn_cidrs                = var.vcn_cidrs
  vcn_dns_label            = var.vcn_dns_label
  vcn_name                 = var.vcn_name
  lockdown_default_seclist = var.lockdown_default_seclist
}

module "subnets" {
  source = "./modules/subnets"

  netnum  = var.netnum
  newbits = var.newbits

  # other required variables
  compartment_id = var.compartment_id
  label_prefix   = var.label_prefix
  vcn_id         = module.vcn.vcn_id
  vcn_cidr       = var.vcn_cidrs.0
  ig_route_id    = module.vcn.ig_route_id
}

# * This module will create a Flex Compute Instance, using default values: 1 OCPU, 16 GB memory.
# * `instance_flex_memory_in_gbs` and `instance_flex_ocpus` are not provided: default values will be applied.
module "instance_flex" {
  source = "oracle-terraform-modules/compute-instance/oci"
  # general oci parameters
  compartment_ocid = var.compartment_id
  freeform_tags    = var.freeform_tags
  defined_tags     = var.defined_tags
  # compute instance parameters
  ad_number                   = var.instance_ad_number
  instance_count              = var.instance_count
  instance_display_name       = var.instance_display_name
#  instance_state              = var.instance_state
  shape                       = var.shape
  source_ocid                 = var.source_ocid
  source_type                 = var.source_type
  instance_flex_memory_in_gbs = 1 # only used if shape is Flex type
  instance_flex_ocpus         = 1 # only used if shape is Flex type
  # operating system parameters
  ssh_public_keys = var.ssh_public_keys
  # networking parameters
  public_ip    = var.public_ip # NONE, RESERVED or EPHEMERAL

  ## This value come from the module subnets
  subnet_ocids = module.subnets.public_subnet_id

  # storage parameters
  boot_volume_backup_policy  = var.boot_volume_backup_policy
  block_storage_sizes_in_gbs = var.block_storage_sizes_in_gbs
}

output "instance_flex" {
  description = "ocid of created instances."
  value       = module.instance_flex.instances_summary

}