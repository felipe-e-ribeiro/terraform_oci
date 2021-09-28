### The Ansible inventory file


resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      private-ip = oci_core_instance.CreateInstance.*.public_ip,
      private-id = oci_core_instance.CreateInstance.*.id
    }
  )
  filename = "inventory"
}

provisioner "local-exec" {
  command = "sleep 90; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ansible -i inventory ' --private-key ${secrets.TF_VAR_SSH_PRIVATE_KEYS} ansible/docker.yml"
}
