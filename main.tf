terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.12.1"
    }
  }
}

locals {
  workload = "bigenterprise"
}

resource "azurerm_resource_group" "default" {
  name     = "rg-${local.workload}"
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
}

module "vm" {
  source                     = "./modules/vm"
  workload                   = local.workload
  resource_group_name        = azurerm_resource_group.default.name
  location                   = azurerm_resource_group.default.location
  subnet_id                  = module.vnet.subnet_id
  size                       = var.vm_size
  install_vmaccess_extension = var.install_vmaccess_extension
}

module "jit" {
  source            = "./modules/jit"
  resource_group_id = azurerm_resource_group.default.id
  location          = azurerm_resource_group.default.location
  vm_id             = module.vm.vm_id
}
