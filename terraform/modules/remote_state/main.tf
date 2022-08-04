terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.77.0"
    }
  }
}

resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "tf-state"
}

resource "yandex_resourcemanager_folder_iam_binding" "tf-account-iam" {
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "tf-bucket-control-iam" {
  folder_id = var.folder_id
  role      = "storage.admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "tf-ydb-control-iam" {
  folder_id = var.folder_id
  role      = "ydb.admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "Static access key for object storage"
}

resource "yandex_kms_symmetric_key" "key" {
  name              = "symetric-key"
  description       = "For bucket encryption"
  default_algorithm = "AES_128"
  labels            = local.labels
}

resource "yandex_storage_bucket" "remote_state" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.bucket_name
  max_size   = var.bucket_max_size

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  anonymous_access_flags {
    read = false
    list = false
  }
}

resource "yandex_ydb_database_serverless" "remote_state" {
  name        = var.ydb_name
  description = "Database for locking resources while working with tf remote state (AWS DynamoDB analogue for s3 backend)"
  folder_id   = var.folder_id
  labels = merge(local.labels, {
    type = "serverless"
    }
  )
}
