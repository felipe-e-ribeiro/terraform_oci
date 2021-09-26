
output "private-security-list-name" {
  value = oci_core_security_list.private-security-list.display_name
}
output "private-security-list-OCID" {
  value = oci_core_security_list.private-security-list.id
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


output "private-subnet-name" {
  value = oci_core_subnet.vcn-private-subnet.display_name
}
output "private-subnet-OCID" {
  value = oci_core_subnet.vcn-private-subnet.id
}
#
