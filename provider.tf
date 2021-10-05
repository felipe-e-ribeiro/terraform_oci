provider "oci" {
#  private_key = var.private_key
}

terraform {
  backend "http" {
    address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/p/BCpqPfopMURdR6kSy0ulhM0HNGANbcTTVVeFvjRk4RxhrADJEntFfs_odHq4TgF-/n/idrw5lfo7fu9/b/TerraformFelipeeduribeiro/o/terraform.tfstate"
    update_method = "PUT"
  }
}

#data "oci_identity_availability_domains" "ads" {
#  compartment_id = oci_identity_compartment.compart_main.id
#}
