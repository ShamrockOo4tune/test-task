terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.77.0"
    }
  }
  backend "s3" {
    key                         = "examples/webserver/terraform.tfstate"
    endpoint                    = "storage.yandexcloud.net"
    region                      = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

module "webserver" {
  source      = "../../modules/webserver"
  zone        = var.zone
  environment = "test"
  vm_name     = var.vm_name
  image_id    = data.yandex_compute_image.required.id
  platform_id = "standard-v2"
  resources = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  nat                = true
  boot_disk_size     = 10
  preemptible        = true
  subnet_id          = data.terraform_remote_state.network.outputs.custom_vpc_subnet_id
  security_group_ids = [data.terraform_remote_state.security_groups.outputs.security_group_id]

  user_data = templatefile(
    "./meta.tftpl", {
      apache_package_name = var.apache_package_name == "empty" ? length(regexall("^(ubuntu|debian|opensuse|sles).*", var.image_family)) > 0 ? "apache2" : "httpd" : var.apache_package_name
      ssh_public_key      = var.ssh_public_key
    }
  )
  serial_port_enable = true
}
