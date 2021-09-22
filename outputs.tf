
output "private-security-list-name" {
  value = oci_core_security_list.private-security-list.display_name
}
output "private-security-list-OCID" {
  value = oci_core_security_list.private-security-list.id
}

# Outputs for public security list

#output "instance_private_and_public_ips" {
#  value = oci_core_instance.CreateInstance["server1"].public_ip
#    for instance_variables in oci_core_instance.CreateInstance.instance_variables : instance_variables.public_ip
#   instance => instance.public_ip
#value = {
#for u in oci_core_instance.CreateInstance : u.public_ip    
#}
#}

#output "instance_private_and_public_ips2" {
#  value = oci_core_instance.CreateInstance["server2"].public_ip
#}



# Outputs for private subnet

output "private-subnet-name" {
  value = oci_core_subnet.vcn-private-subnet.display_name
}
output "private-subnet-OCID" {
  value = oci_core_subnet.vcn-private-subnet.id
}
#
