variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "deploy_location"     {default = "westus2"}
variable "resource_group_name" {default = "udemyLearnPacker"}

provider "azurerm" {
  version         = "= 1.20"

  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
}

resource "azurerm_resource_group" "packer_deploy_rg" {
  name     = "${var.resource_group_name}"
  location = "${var.deploy_location}"
}

resource "azurerm_virtual_network" "packer_vnet" {
  name                = "packer-vnet" 
  resource_group_name = "${azurerm_resource_group.packer_deploy_rg.name}"
  location            = "${var.deploy_location}"
  address_space       = ["1.0.0.0/24"]
}

resource "azurerm_subnet" "learn-packer_subnet" {
  name                 = "packer-subnet" 
  resource_group_name  = "${azurerm_resource_group.packer_deploy_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.packer_vnet.name}"
  address_prefix       = "1.0.0.0/24"
}

resource "azurerm_network_security_group" "packer_nsg" {
  name                = "packer-nsg"
  location            = "${var.deploy_location}"
  resource_group_name = "${azurerm_resource_group.packer_deploy_rg.name}"
}

resource "azurerm_network_security_rule" "packer_nsg_rule_rdp" {
  name                        = "RDP Inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.packer_deploy_rg.name}"
  network_security_group_name = "${azurerm_network_security_group.packer_nsg.name}"
}

resource "azurerm_network_security_rule" "packer_nsg_rule_http" {
  name                        = "HTTP Inbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.packer_deploy_rg.name}"
  network_security_group_name = "${azurerm_network_security_group.packer_nsg.name}"
}