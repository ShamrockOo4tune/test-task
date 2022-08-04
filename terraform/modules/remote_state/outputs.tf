output "bucket_access_key_init_str" {
  value = "access_key = \"${yandex_iam_service_account_static_access_key.sa-static-key.access_key}\""
}

output "bucket_secret_key_init_str" {
  value = "secret_key = \"${yandex_iam_service_account_static_access_key.sa-static-key.secret_key}\""
}

output "bucket_name_init_str" {
  value = "bucket = \"${yandex_storage_bucket.remote_state.bucket}\""
}

output "ydb_api_endpoint" {
  value = "# dynamodb_endpoint = \"${yandex_ydb_database_serverless.remote_state.document_api_endpoint}\""
}
