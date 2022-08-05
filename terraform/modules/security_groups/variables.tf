variable "environment" {
  type        = string
  description = "What environment do we place the resources to? [ test | dev | stage | prod ] ?"
}

variable "name" {
  type        = string
  description = "Provide name of the security group"
}

variable "network_id" {
  type        = string
  description = "The id of the network in which the security group needs to be created"
}
