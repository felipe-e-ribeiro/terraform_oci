variable "compartment_root_id" {
  type = string
}

variable "private_key" {
  type = string
}

variable "compartment" {
  type    = string
  default = "Compart_Felipe"
}

variable "instance_app_name" {
  type    = string
  default = "test-instance"
}

variable "ssh_authorized_keys" {
  type = string
}

variable "instance_variables" {
  description = "Map instance name to hostname"
  default = {
    "server1" = "server-free01"
    "server2" = "server-free02"
  }
}

############ NETWORK #######
variable "subnet_name" {
  type    = string
  default = "vcn_felps"
}
variable "subnet_label" {
  type    = string
  default = "felps"
}
variable "subnet" {
  type    = string
  default = "10.250.252.0/23"
}
variable "public_subnet" {
  type    = string
  default = "10.250.252.0/24"
}
variable "private_subnet" {
  type    = string
  default = "10.250.253.0/24"
}
variable "client_domain" {
  type    = string
  default = "libbers.ddns.net"
}

locals {
  portas_liberadas = [22, 80, 443, 9090, 8080, 5000]
}
##### VARIAVEIS PADROES #####

#CentOS 8 imagem
variable "server_app" {
  type    = string
  default = "ocid1.image.oc1.iad.aaaaaaaadzlyimwgplwurg2nm5yiwbz4ah6hlj2aasrvq5mzcxb7reohpfka"
}

variable "shape_list" {
  type = map(any)
  default = {
    "FREE"     = "VM.Standard.E2.1.Micro"
    "1CPU_AMD" = "VM.Standard.E2.1"
    "2CPU_AMD" = "VM.Standard.E2.2"
    "4CPU_AMD" = "VM.Standard.E2.4"
    "1CPU_INT" = "VM.Standard2.1"
    "2CPU_INT" = "VM.Standard2.2"
    "4CPU_INT" = "VM.Standard2.4"
  }
}
