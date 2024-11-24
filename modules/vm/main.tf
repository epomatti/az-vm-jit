resource "azurerm_public_ip" "default" {
  name                = "pip-${var.workload}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "default" {
  name                = "nic-${var.workload}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.default.id
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_linux_virtual_machine" "default" {
  name                  = "vm-${var.workload}3"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = "P@ssw0rd.123"
  network_interface_ids = [azurerm_network_interface.default.id]

  custom_data = filebase64("${path.module}/userdata/ubuntu.sh")

  identity {
    type = "SystemAssigned"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  os_disk {
    name                 = "osdisk-linux-${var.workload}"
    caching              = "ReadOnly"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server-arm64"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "AzureMonitorLinuxAgent" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.default.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.33.1" # https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-extension-versions
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
}

resource "azurerm_virtual_machine_extension" "VMAccessForLinux" {
  count                      = var.install_vmaccess_extension ? 1 : 0
  name                       = "VMAccessForLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.default.id
  publisher                  = "Microsoft.OSTCExtensions"
  type                       = "VMAccessForLinux"
  type_handler_version       = "1.5"
  auto_upgrade_minor_version = true

  # TODO: Check this in production
  protected_settings = jsonencode({
    "username" : "currentusername",
    "password" : "newpassword",
    "reset_ssh" : "false"
  })
}
