variable "bucket_name" {
  type        = string
  description = "Name for the bucket"
}

variable "ydb_name" {
  type        = string
  description = "Name for the remote backend serverless ydb. Will be used for resource locking"
}

variable "environment" {
  type        = string
  description = "What environment do we place the resources to? [ test | dev | stage | prod ] ?"
}

variable "folder_id" {
  type        = string
  description = "The ID of the folder in the cloud"
}

variable "bucket_max_size" {
  type        = number
  description = "Size of the bucket in bytes"
  default     = 1073741824 // 1Gb
  validation {
    condition = (
      var.bucket_max_size >= 1073741824 &&
      var.bucket_max_size <= 53687091200
    )
    error_message = "Allowed size range 1 Gb - 50 Gb"
  }
}
