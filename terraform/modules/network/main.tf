terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.77.0"
    }
  }
}

resource "yandex_vpc_network" "custom" {
  name      = var.vpc_name
  labels    = local.labels
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "custom" {
  name           = var.subnet_name
  network_id     = yandex_vpc_network.custom.id
  v4_cidr_blocks = var.subnet_cidrs
  labels         = local.labels
}
