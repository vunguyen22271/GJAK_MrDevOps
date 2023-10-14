resource "azurerm_resource_group" "main_rg" {
  name = "${local.prefix}_rg"
  location = "${var.mainLocation}"
}

resource "azurerm_virtual_network" "vn" {
  name                = "${local.prefix}_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "${local.prefix}_public_subnet"
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.1.0/24"]
}