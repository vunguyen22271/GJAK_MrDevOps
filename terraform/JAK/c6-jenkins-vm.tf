# Static IP
data "azurerm_public_ip" "jenkins_ip" {
  name                = "${local.ipPrefix}_jenkins_ip"
  resource_group_name = "${local.ipPrefix}_rg"
}

# Network Interface
resource "azurerm_network_interface" "jenkins_nic" {
  name                = "${local.prefix}_jenkins_nic"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "${local.prefix}_jenkin_nic_configuration"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.4"
    public_ip_address_id          = data.azurerm_public_ip.jenkins_ip.id
  }
}

# Network Security Group and Network Security Rule
resource "azurerm_network_security_group" "jenkins_nsg" {
  name                = "${local.prefix}_jenkins_nsg"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "http"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Prometheus"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9090"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Grafana"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Node_Exporter"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9100"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate Network Interface and Network Security Group
resource "azurerm_network_interface_security_group_association" "jenkins_nic_nsg" {
  network_interface_id      = azurerm_network_interface.jenkins_nic.id
  network_security_group_id = azurerm_network_security_group.jenkins_nsg.id
}

resource "azurerm_linux_virtual_machine" "jenkins_vm" {
  name                  = "${local.prefix}_jenkins_vm"
  location              = azurerm_resource_group.main_rg.location
  resource_group_name   = azurerm_resource_group.main_rg.name
  network_interface_ids = [azurerm_network_interface.jenkins_nic.id]
  size                  = "Standard_B1ms"

  os_disk {
    name                 = "${local.prefix}_public_OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "jeknins"
  admin_username                  = var.vm_user
  admin_password                  = var.vm_pass
  disable_password_authentication = false

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = var.vm_user
      password    = var.vm_pass
      host        = data.azurerm_public_ip.pip.ip_address
      # private_key = tls_private_key.ssh_key.private_key_pem
      agent       = false
      timeout     = "1m"
    }
    source      = "../docker_monitor_config"
    destination = "/home/${var.vm_user}"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.vm_user
      password    = var.vm_pass
      host        = data.azurerm_public_ip.pip.ip_address
      # private_key = tls_private_key.ssh_key.private_key_pem
      agent       = false
      timeout     = "1m"
    }
    script = "public_run_docker.sh"
  }
}


