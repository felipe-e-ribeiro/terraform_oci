
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

resource "local_file" "AuthFile" {
  sensitive_content = templatefile("./inventory.tmpl",
    {
      private-ip = oci_core_instance.CreateInstance.*.public_ip,
      private-id = oci_core_instance.CreateInstance.*.id
    }
  )
  filename = "./ansible/inventory"
}


resource "local_file" "AnsibleInventory" {
  sensitive_content = templatefile("./credentials/ssh_private",
    {
      ssh-key = var.auth_ssh_key
    }
  )
  filename        = "private_key"
  file_permission = "0600"
}
