resource "vultr_kubernetes" "this" {
  label   = var.project_name
  region  = var.region
  version = "v1.34.1+3"

  node_pools {
    node_quantity = 2
    plan          = "vc2-4c-8gb"
    label         = "worker-pool"
  }
}

resource "vultr_container_registry" "this" {
  name   = var.registry_name
  region = var.region

  public = false
  plan   = "start_up"
}

