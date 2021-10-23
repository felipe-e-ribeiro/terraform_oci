
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

  depends_on = [oci_core_instance.CreateInstance]
}

output "public_ips" {
  value = {
    for k, v in oci_core_instance.CreateInstance : k => v.public_ip
  }

  depends_on = [oci_core_instance.CreateInstance]
}

resource "local_file" "AuthFile" {
  #  for_each = oci_core_instance.CreateInstance
  sensitive_content = templatefile("./ansible/inventory.tmpl",
    {
      #private-ip = oci_core_instance.CreateInstance.*.public_ip
      #private-ip = [ for k, v in oci_core_instance.CreateInstance : k => v.public_ip ]
      private-ip = { for s, v in oci_core_instance.CreateInstance : s => v.public_ip }
      #private-id = oci_core_instance.CreateInstance.*.id
      private-id = { for s, v in oci_core_instance.CreateInstance : s => v.id }
      #private-id = each.value.id
    }
  )
  filename   = "./ansible/inventory"
  depends_on = [oci_core_instance.CreateInstance]
}


resource "local_file" "AnsibleInventory" {
  sensitive_content = templatefile("./credentials/private_key.tmpl",
    {
      ssh-key = var.auth_ssh_key
    }
  )
  filename        = "./credentials/private_key"
  file_permission = "0600"
}
