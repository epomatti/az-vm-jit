variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "workload" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "install_vmaccess_extension" {
  type = bool
}
