resource "azuread_application" "server" {
  name                       = "${var.platform_fqdn}Server"
  homepage                   = "https://${var.platform_fqdn}"
  identifier_uris            = ["https://${var.platform_fqdn}Server"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
  type                       = "webapp/api"
  group_membership_claims    = "All"

  required_resource_access {
    //Microsoft Graph
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    //https://marketplace.visualstudio.com/items?itemName=stephane-eyskens.aadv1appprovisioning

    //Delegated Permission - User.Read
    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }

    //Delegated Permission - Directory.Read.All
    resource_access {
      id   = "06da0dbc-49e2-44d2-8312-53f166ab848a"
      type = "Scope"
    }

    //Application Permission - Directory.Read.All
    resource_access {
      id   = "7ab1d382-f21e-4acd-a863-ba3e13f7da61"
      type = "Role"
    }
  }
}

resource "azuread_application" "client" {
  name                       = "${var.platform_fqdn}Client"
  homepage                   = "https://${var.platform_fqdn}"
  reply_urls                 = ["https://${var.platform_fqdn}Client"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
  type                       = "native"

  required_resource_access {
    resource_app_id = azuread_application.server.application_id


    resource_access {
      id   = azuread_application.server.oauth2_permissions[0].id
      type = "Scope"
    }
  }
}