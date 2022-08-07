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

data "terraform_remote_state" "security_groups" {
  backend = "s3"
  config = {
    endpoint                    = "storage.yandexcloud.net"
    region                      = "ru-central1"
    key                         = "examples/security_groups/terraform.tfstate"
    bucket                      = var.bucket
    access_key                  = var.access_key
    secret_key                  = var.secret_key
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

data "yandex_compute_image" "required" {
  family = var.image_family
}
