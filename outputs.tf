
data "oci_core_vnic_attachments" "test_vnic_attachments" {
    #Required
    compartment_id = oci_identity_compartment.compart_main.id
}

data "oci_core_instances" "test_instances" {
  compartment_id = oci_identity_compartment.compart_main.id
}

output "public_hostname" {
  value = {
    for k, v in oci_core_instance.CreateInstance : k => v.display_name
  }

  depends_on = [oci_core_instance.CreateInstance[0]]
}

output "public_ips" {
  value = {
    for k, v in oci_core_instance.CreateInstance : k => v.public_ip
  }

  depends_on = [oci_core_instance.CreateInstance[0]]
}

output "load_balancer_ip" {
  value = {
    for k, v in oci_load_balancer_load_balancer.load_balancer.ip_address_details : k => lookup(v, "ip_address")
  }
  depends_on = [oci_load_balancer_load_balancer.load_balancer]
}
