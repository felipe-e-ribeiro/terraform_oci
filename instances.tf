data "oci_identity_availability_domains" "ads" {
  compartment_id = oci_identity_compartment.compart_main.id
}


resource "oci_core_instance" "CreateInstance" {
  #for_each            = var.instance_variables
  count               = 1
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
  compartment_id      = oci_identity_compartment.compart_main.id
  shape               = var.shape_list["FREE"]

  display_name = "${var.instance_app_name}-0${count.index + 1}"
  source_details {
    source_id   = var.server_app
    source_type = "image"
  }
  create_vnic_details {
    subnet_id        = oci_core_subnet.vcn-public-subnet.id
    display_name     = "${var.instance_app_name}-${count.index + 1}"
    hostname_label   = "${var.instance_app_name}-${count.index + 1}"
    assign_public_ip = true
  }
  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
  }
}
