variable "environment" {
  type        = string
  description = "What environment do we place the resources to? [ test | dev | stage | prod ] ?"
}

variable "vm_name" {
  type        = string
  description = "Provide name of the virtual machine"
}

variable "platform_id" {
  type        = string
  description = "Provide the id of the virtual machine type example: standard-v2"
}

variable "resources" {
  type        = map(number)
  description = "Provide 'resources' parameter for the vm"
}

variable "preemptible" {
  type        = bool
  description = "Set to true if vm should be preemptyble (low cost)"
  default     = false
}

variable "subnet_id" {
  type        = string
  description = "The id of the subnet in which the vm will be created"
}

variable "nat" {
  type        = bool
  description = "Set to true if nat required"
  default     = false
}

variable "security_group_ids" {
  type        = list(string)
  description = "Provide list of security groups"
}

variable "image_id" {
  type        = string
  description = "ID of the image to run on the vm"
}

variable "boot_disk_size" {
  type        = number
  description = "Size of the vm's boot disk in Gb"
}

variable "zone" {
  type        = string
  description = "In what zone should the vm start"
}

variable "user_data" {
  type        = string
  description = "Init script"
}

variable "serial_port_enable" {
  type        = bool
  description = "enable web console access from YC"
  default     = false
}
