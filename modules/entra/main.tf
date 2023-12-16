data "azuread_client_config" "current" {}

### Groups ###
resource "azuread_group" "group1" {
  display_name     = "Group1"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true

  # Enables PIM
  assignable_to_role = true
}

resource "azuread_group" "group2" {
  display_name     = "Group2"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true

  # Enables PIM
  assignable_to_role = true
}

### Users ###
resource "azuread_user" "user1" {
  account_enabled     = true
  user_principal_name = "User1@${var.entraid_tenant_domain}"
  display_name        = "User1"
  mail_nickname       = "User1"
  password            = var.generic_password
}

resource "azuread_user" "user2" {
  account_enabled     = true
  user_principal_name = "User2@${var.entraid_tenant_domain}"
  display_name        = "User2"
  mail_nickname       = "User2"
  password            = var.generic_password
}

resource "azuread_user" "user3" {
  account_enabled     = true
  user_principal_name = "User3@${var.entraid_tenant_domain}"
  display_name        = "User3"
  mail_nickname       = "User3"
  password            = var.generic_password
}

### Group Membership ###
resource "azuread_group_member" "user1_group1" {
  group_object_id  = azuread_group.group1.id
  member_object_id = azuread_user.user1.id
}

resource "azuread_group_member" "user2_group2" {
  group_object_id  = azuread_group.group2.id
  member_object_id = azuread_user.user2.id
}

resource "azuread_group_member" "user3_group1" {
  group_object_id  = azuread_group.group1.id
  member_object_id = azuread_user.user3.id
}

resource "azuread_group_member" "user3_group2" {
  group_object_id  = azuread_group.group2.id
  member_object_id = azuread_user.user3.id
}
