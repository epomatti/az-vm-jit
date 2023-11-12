terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

resource "azapi_resource" "jit" {
  type      = "Microsoft.Security/locations/jitNetworkAccessPolicies@2020-01-01"
  name      = "LinuxJITPolicy"
  parent_id = "${var.resource_group_id}/providers/Microsoft.Security/locations/${var.location}"
  body = jsonencode({
    properties = {
      virtualMachines = [
        {
          id = "${var.vm_id}"
          ports = [
            {
              maxRequestAccessDuration   = "PT3H"
              number                     = 22
              protocol                   = "*"
              allowedSourceAddressPrefix = "*"
            }
          ]
        }
      ]
    }
    kind = "Basic"
  })
}
