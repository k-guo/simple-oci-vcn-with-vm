resource "oci_core_security_list" "public" {
  compartment_id = var.compartment_id
  display_name   = "${var.label_prefix}-public"
  vcn_id = var.vcn_id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    # allow ssh
    protocol = 6
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    # allow http
    protocol = 6
    source   = "0.0.0.0/0"

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    # allow https
    protocol = 6
    source   = "0.0.0.0/0"

    tcp_options {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_security_list" "private" {
  compartment_id = var.compartment_id
  display_name   = "${var.label_prefix}-private"
  vcn_id = var.vcn_id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    # allow ssh
    protocol = 6
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    # allow http
    protocol = 6
    source   = "0.0.0.0/0"

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    # allow https
    protocol = 6
    source   = "0.0.0.0/0"

    tcp_options {
      min = 443
      max = 443
    }
  }
}