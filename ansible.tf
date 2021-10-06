resource "local_file" "AuthFile" {
  sensitive_content = templatefile("./ansible/inventory.tmpl",
    {
      private-ip = oci_core_instance.CreateInstance.*.public_ip,
      private-id = oci_core_instance.CreateInstance.*.id
    }
  )
  filename = "./ansible/inventory"
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

resource "null_resource" "AnsibleProvisioning" {
  provisioner "local-exec" {
    command    = "sleep 180; export ANSIBLE_HOST_KEY_CHECKING=False ; ansible-playbook -i \"./ansible/inventory\" --private-key \"./credentials/private_key\" ./ansible/docker.yml"
  }
    depends_on = [oci_core_instance.CreateInstance]
}
