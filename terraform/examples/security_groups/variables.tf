variable "token" {
  description = "Yandex Cloud security OAuth token"
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID where resources will be created"
}

variable "cloud_id" {
  description = "Yandex Cloud ID where resources will be created"
}

### Group of link_to_backend.auto.tfvars variables
### The following varibles come from file:
### link_to_backend.auto.tfvars --> ../remote-state/backend.auto.tfvars.
### ../remote-state/backend.auto.tfvars is autogenerated as a result of apply in remote-state module.
### The purpose of this vars is to work with remote backend for terraform state. 

variable "access_key" {
  type        = string
  description = "Belongs to 'backend.auto.tfvars' group"
}

variable "secret_key" {
  type        = string
  description = "Belongs to 'backend.auto.tfvars' group"
}

variable "bucket" {
  type        = string
  description = "Belongs to 'backend.auto.tfvars' group"
}

variable "dynamodb_endpoint" {
  type        = string
  description = "Belongs to 'backend.auto.tfvars' group"
}