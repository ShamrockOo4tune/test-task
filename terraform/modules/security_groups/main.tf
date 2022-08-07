terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.77.0"
    }
  }
}

resource "yandex_vpc_security_group" "custom" {
  name        = var.name
  description = "Custom security group for web servers"
  network_id  = var.network_id
  labels = merge(
    local.labels, {
      network_id = var.network_id
    }
  )

  ingress {
    protocol       = "TCP"
    description    = "allow all http in"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "allow all ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "allow all out"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = -1
    to_port        = -1
  }
}
