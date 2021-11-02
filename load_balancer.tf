resource "oci_load_balancer_load_balancer" "load_balancer" {
  count          = var.enable_lb ? 1 : 0
  compartment_id = oci_identity_compartment.compart_main.id
  display_name   = "LoadBalancer"
  shape          = "flexible"
  subnet_ids     = ["${oci_core_subnet.vcn-public-subnet.id}"]

  shape_details {
    maximum_bandwidth_in_mbps = "10"
    minimum_bandwidth_in_mbps = "10"
  }
  depends_on = [oci_core_instance.CreateInstance]
}

resource "oci_load_balancer_listener" "http_listener" {
  default_backend_set_name = oci_load_balancer_backend_set.backend_set.name
  load_balancer_id         = oci_load_balancer_load_balancer.load_balancer[0].id
  name                     = "Listener-80"
  port                     = "80"
  protocol                 = "HTTP"
  depends_on               = [oci_load_balancer_load_balancer.load_balancer]
}

resource "oci_load_balancer_backend_set" "backend_set" {
  health_checker {
    protocol = "HTTP"
    url_path = "/"
  }
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer[0].id
  name             = "BackEndSet"
  policy           = "LEAST_CONNECTIONS"
  depends_on       = [oci_load_balancer_load_balancer.load_balancer]
}

resource "oci_load_balancer_backend" "backend" {
  for_each = { for k, v in oci_core_instance.CreateInstance : k => lookup(v, "private_ip") }

  backendset_name  = oci_load_balancer_backend_set.backend_set.name
  ip_address       = each.value
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer[0].id
  port             = "80"
  depends_on       = [oci_load_balancer_load_balancer.load_balancer]
}
