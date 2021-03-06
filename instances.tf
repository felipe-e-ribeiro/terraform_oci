data "oci_identity_availability_domains" "ads" {
  compartment_id = oci_identity_compartment.compart_main.id
}


resource "oci_core_instance" "CreateInstance" {
  for_each            = var.instances_iaas
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
  compartment_id      = oci_identity_compartment.compart_main.id
  shape               = each.value.shape_type
  shape_config {
    memory_in_gbs = each.value.memory_flex != 0 ? each.value.memory_flex : 1
    ocpus         = each.value.cpu_flex != 0 ? each.value.cpu_flex : 1
  }


  display_name = each.value.hostname
  source_details {
    source_id   = var.server_app
    source_type = "image"
  }
  create_vnic_details {
    subnet_id        = oci_core_subnet.vcn-public-subnet.id
    display_name     = each.value.hostname
    hostname_label   = each.value.hostname
    assign_public_ip = true
  }
  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
  }
}
