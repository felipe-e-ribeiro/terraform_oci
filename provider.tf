provider "oci" {
  private_key = var.private_key
  region      = "us-ashburn-1"
}

terraform {
  backend "s3" {
    bucket   = "TerraformFelipeeduribeiro"
    key      = "terraform.tfstate"
    region   = "us-ashburn-1"
    endpoint = "https://idrw5lfo7fu9.compat.objectstorage.us-ashburn-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}
