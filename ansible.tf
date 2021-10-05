resource "null_resource" "AnsibleProvisioning" {
  provisioner "local-exec" {
  command = "sleep 120; export ANSIBLE_HOST_KEY_CHECKING=False ; ansible-playbook -i \"./ansible/inventory\" --private-key \"./credentials/private_key\" ./ansible/docker.yml"
 }
}

