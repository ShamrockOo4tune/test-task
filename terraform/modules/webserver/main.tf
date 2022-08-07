terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.77.0"
    }
  }
}

resource "yandex_compute_instance" "webserver" {
  name                      = var.vm_name
  platform_id               = var.platform_id
  zone                      = var.zone
  allow_stopping_for_update = true
  metadata = {
    user-data          = var.user_data
    serial-port-enable = var.serial_port_enable
  }

  resources {
    cores         = var.resources["cores"]
    memory        = var.resources["memory"]
    core_fraction = var.resources["core_fraction"]
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.boot_disk_size
    }
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = var.nat
    security_group_ids = var.security_group_ids
  }

  lifecycle {
    ignore_changes = [boot_disk[0].initialize_params[0].image_id]
  }
  labels = local.labels
}
