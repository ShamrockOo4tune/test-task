terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.77.0"
    }
  }
  backend "s3" {
    key                         = "examples/network/terraform.tfstate"
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
  zone      = var.zone
}

module "network" {
  source       = "../../modules/network"
  folder_id    = var.folder_id
  environment  = "test"
  vpc_name     = var.vpc_name
  subnet_name  = var.subnet_name
  subnet_cidrs = var.subnet_cidrs
}
