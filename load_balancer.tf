#data "oci_core_public_ips" "public_ips" {
#    compartment_id = oci_identity_compartment.compart_main.id
#    scope = "AVAILABILITY_DOMAIN"
#    lifetime = "EPHEMERAL"
#    assigned_entity_type = "PRIVATE_IP"
#    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
#}

resource "oci_load_balancer_load_balancer" "load_balancer" {
    compartment_id = oci_identity_compartment.compart_main.id
    display_name = "LoadBalancer"
    shape = "flexible"
    subnet_ids = [ "${oci_core_subnet.vcn-public-subnet.id}" ]

    shape_details {
        maximum_bandwidth_in_mbps = "10"
        minimum_bandwidth_in_mbps = "10"
    }
}

resource "oci_load_balancer_listener" "http_listener" {
    default_backend_set_name = oci_load_balancer_backend_set.backend_set.name
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    name = "Listener-80"
    port = "80"
    protocol = "HTTP"
}

resource "oci_load_balancer_backend_set" "backend_set" {
    health_checker {
        protocol = "HTTP"
        url_path = "/"
    }
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    name = "BackEndSet"
    policy = "LEAST_CONNECTIONS"
}

resource "oci_load_balancer_backend" "backend" {
  for_each = { for x in oci_core_instance.CreateInstance: x.private_ip => x }
    
  backendset_name = oci_load_balancer_backend_set.backend_set.name
  ip_address = each.key
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  port = "80"
}
