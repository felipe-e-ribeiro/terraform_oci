resource "oci_identity_compartment" "compart_main" {
  compartment_id = var.compartment_root_id
  description    = var.compartment
  name           = var.compartment
}
