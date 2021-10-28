resource "oci_core_subnet" "public" {
  cidr_block                 = cidrsubnet(var.vcn_cidr, var.newbits["public"], var.netnum["public"])
  compartment_id             = var.compartment_id
  display_name               = "${var.label_prefix}-public"
  dns_label                  = "public"
  prohibit_public_ip_on_vnic = false
  route_table_id             = var.ig_route_id
  security_list_ids          = [oci_core_security_list.public.id]
  vcn_id                     = var.vcn_id
}

resource "oci_core_subnet" "private" {
  cidr_block                 = cidrsubnet(var.vcn_cidr, var.newbits["private"], var.netnum["private"])
  compartment_id             = var.compartment_id
  display_name               = "${var.label_prefix}-private"
  dns_label                  = "private"
  prohibit_public_ip_on_vnic = true
  route_table_id             = var.ig_route_id
  security_list_ids          = [oci_core_security_list.private.id]
  vcn_id                     = var.vcn_id
}