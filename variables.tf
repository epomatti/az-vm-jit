variable "location" {
  type    = string
  default = "eastus2"
}

# TODO: This was having issues with ARM64
variable "vm_size" {
  type    = string
  default = "Standard_B2pts_v2"
}
