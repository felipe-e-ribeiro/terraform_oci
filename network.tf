
resource "oci_core_vcn" "vcn_main" {
  compartment_id = oci_identity_compartment.compart_main.id

  cidr_blocks  = [var.subnet]
  display_name = var.subnet_name
  dns_label    = var.subnet_label
}

resource "oci_core_subnet" "vcn-private-subnet" {

  compartment_id    = oci_identity_compartment.compart_main.id
  vcn_id            = oci_core_vcn.vcn_main.id
  cidr_block        = var.private_subnet
  route_table_id    = oci_core_route_table.route_private.id
  security_list_ids = [oci_core_security_list.private-security-list.id]
  display_name      = "private-subnet"
  dns_label         = "felpsprivate"
}

resource "oci_core_subnet" "vcn-public-subnet" {

  compartment_id    = oci_identity_compartment.compart_main.id
  vcn_id            = oci_core_vcn.vcn_main.id
  cidr_block        = var.public_subnet
  route_table_id    = oci_core_route_table.route_public.id
  security_list_ids = [oci_core_security_list.public-security-list.id]
  display_name      = "public-subnet"
  dns_label         = "felpspublic"
}

resource "oci_core_dhcp_options" "dhcp-options" {

  compartment_id = oci_identity_compartment.compart_main.id
  vcn_id         = oci_core_vcn.vcn_main.id

  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }
  display_name = "default-dhcp-options"
}

### Nat Gateway
#resource "oci_core_nat_gateway" "nat_gateway" {
#    compartment_id = oci_identity_compartment.compart_main.id
#    vcn_id = oci_core_vcn.vcn_main.id
#    display_name = "Nat_Gateway"
#}

### DRG
#data "oci_core_drgs" "drg_network" {
#    compartment_id = oci_identity_compartment.compart_main.id
#}
