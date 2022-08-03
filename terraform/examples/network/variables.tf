variable "zone" {
  type        = string
  description = "TC zone in which the network resources will be created"
  default     = "ru-central1-c"
}

variable "vpc_name" {
  type        = string
  description = "Name for the custom vpc"
  default     = "my_vpc"
}

variable "subnet_name" {
  type        = string
  description = "Name for the subnet in custom vpc"
  #default     = "my_subnet"
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "Provide list of the cidr blocs for custom subnet. Example: [\"192.168.10.0/24\"]"
  #default     = ["192.168.10.0/24"]
}

variable "token" {
  description = "Yandex Cloud security OAuth token"
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID where resources will be created"
}

variable "cloud_id" {
  description = "Yandex Cloud ID where resources will be created"
}
