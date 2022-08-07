terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.77.0"
    }
  }
  backend "s3" {
    key                         = "examples/security_groups/terraform.tfstate"
    endpoint                    = "storage.yandexcloud.net"
    region                      = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    endpoint                    = "storage.yandexcloud.net"
    region                      = "ru-central1"
    key                         = "examples/network/terraform.tfstate"
    bucket                      = var.bucket
    access_key                  = var.access_key
    secret_key                  = var.secret_key
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

module "security_groups" {
  source      = "../../modules/security_groups"
  environment = "test"
  name        = "simple_http"
  network_id  = data.terraform_remote_state.network.outputs.custom_vpc_network_id
}

output "security_group_id" {
  value = module.security_groups.security_group_id
}
