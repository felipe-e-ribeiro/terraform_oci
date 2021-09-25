### Internet Gateway
resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = oci_identity_compartment.compart_main.id

  display_name = "Internet_Gateway"
  vcn_id       = oci_core_vcn.vcn_main.id
}



# PUBLIC NETWORK
resource "oci_core_route_table" "route_public" {
  compartment_id = oci_identity_compartment.compart_main.id
  vcn_id         = oci_core_vcn.vcn_main.id
  display_name   = "Route Public"


  ## DEFAULT ROUTE PUBLIC
  route_rules {
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
    description       = "Rota default"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}


# PRIVATE NETWORK
resource "oci_core_route_table" "route_private" {
  compartment_id = oci_identity_compartment.compart_main.id
  vcn_id         = oci_core_vcn.vcn_main.id
  display_name   = "Route Private"
}
