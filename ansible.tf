resource "null_resource" "AnsibleProvisioning" {
  provisioner "local-exec" {
    command    = "sleep 180; export ANSIBLE_HOST_KEY_CHECKING=False ; ansible-playbook -i \"./ansible/inventory\" --private-key \"./credentials/private_key\" ./ansible/docker.yml"
  }
    depends_on = [oci_core_instance.CreateInstance]
}
