resource "azurerm_network_security_group" "ngs_suxen_sandbox" {
  name                = "ngs_suxen_sandbox"
  location            = var.location
  resource_group_name = var.shared_resource_group_name
}

resource "azurerm_network_security_rule" "nsg_ingress_rules" {
  for_each                    = var.ingress_rule
  name                        = "ingress_${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.shared_resource_group_name
  network_security_group_name = azurerm_network_security_group.ngs_suxen_sandbox.name
}

# resource "azurerm_network_security_rule" "nsg_outbund_rules" {
#   for_each                    = var.outbound_rule
#   name                        = "outbound_${each.value}"
#   priority                    = each.key
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = each.value
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.shared_resource_group_name
#   network_security_group_name = azurerm_network_security_group.ngs_suxen_sandbox.name
# }
