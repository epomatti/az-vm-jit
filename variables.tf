variable "location" {
  type    = string
}

variable "vm_size" {
  type = string
}

variable "entraid_tenant_domain" {
  type = string
}

variable "generic_password" {
  type      = string
  sensitive = true
}
