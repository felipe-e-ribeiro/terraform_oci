resource "oci_core_security_list" "private-security-list"{
  compartment_id = oci_identity_compartment.compart_main.id
  vcn_id = oci_core_vcn.vcn_main.id
  display_name = "security-list-for-private-subnet"

  egress_security_rules {
      stateless = false
      destination = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      protocol = "all"
  }

  egress_security_rules {
      stateless = false
      destination = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      protocol = "all"
  }

  dynamic "ingress_security_rules" {
  for_each = local.portas_liberadas
  content {
	stateless = false
        source = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"
        protocol = "6"
        tcp_options {
        min = ingress_security_rules.value
        max = ingress_security_rules.value
      }
   }
 }

  ingress_security_rules {
      stateless = false
      source = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      protocol = "1"

      icmp_options {
        type = 3
        code = 4
      }
    }
}
############## LIBERACAO SUBNET PUBLIC ######################
resource "oci_core_security_list" "public-security-list"{

  compartment_id = oci_identity_compartment.compart_main.id
  vcn_id = oci_core_vcn.vcn_main.id

  display_name = "security-list-for-public-subnet"

  egress_security_rules {
      stateless = false
      destination = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      protocol = "all"
  }

  dynamic "ingress_security_rules" {
  for_each = local.portas_liberadas
  content {
	stateless = false
        source = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"
        protocol = "6"
        tcp_options {
        min = ingress_security_rules.value
        max = ingress_security_rules.value
      }
   }
 }

### Liberacao Full local
 ingress_security_rules {
      stateless = false
      source = var.subnet
      source_type = "CIDR_BLOCK"
      protocol = "all"
      }

 
 ingress_security_rules {
      stateless = false
      source = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      protocol = "1"

      icmp_options {
        type = 3
        code = 4
      }
    }
}
