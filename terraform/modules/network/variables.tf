variable "folder_id" {
  type        = string
  description = "In what folder will the resource be created"
}

variable "environment" {
  type        = string
  description = "What environment do we place the resources to? [ test | dev | stage | prod ] ?"
}

variable "vpc_name" {
  type        = string
  description = "Provide name for the custom vpc"
}

variable "subnet_name" {
  type        = string
  description = "Provide name for the subnet in custom vpc"
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "Provide list of the cidr blocs for custom subnet. Example: [\"192.168.10.0/24\"]"
}
