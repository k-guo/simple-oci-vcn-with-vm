

variable "netnum" {
  description = "zero-based index of the subnet when the network is masked with the newbit. use as netnum parameter for cidrsubnet function"
  default = {
    public   = 1
    private  = 0
  }
  type = map
}

variable "newbits" {
  description = "new mask for the subnet within the virtual network. use as newbits parameter for cidrsubnet function"
  default = {
    public  = 1
    private = 1
  }
  type = map
}

# general oci parameters

variable "compartment_id" {
  description = "compartment id where to create all resources"
  type        = string
  # no default value, asking user to explicitly set this variable's value. see codingconventions.adoc
}

variable "label_prefix" {
  description = "a string that will be prepended to all resources"
  type        = string
  default     = "terraform-oci"
}

variable "vcn_id" {
  description = "vcn id"
  type        = string
}

# vcn parameters

variable "vcn_cidr" {
  description = "The VCN CIDr the subnets will be created from"
  type        = string
}

variable "ig_route_id" {
  description = "id of internet gateway route table"
}