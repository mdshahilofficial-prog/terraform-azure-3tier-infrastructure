locals {

  # --------------------------------------------------
  # Bastion
  # --------------------------------------------------

  bastions = {
    for key, bastion in var.bastions : key => {
      name                 = bastion.name
      resource_group_name  = bastion.resource_group_name
      location             = bastion.location
      sku                  = bastion.sku
      subnet_id            = module.subnet.subnet_ids[bastion.subnet_key]
      public_ip_address_id = module.pip.public_ip_ids[bastion.public_ip_key]
    }
  }


  # --------------------------------------------------
  # Subnet NSG Associations
  # --------------------------------------------------

  subnet_nsg_associations = {
    for key, association in var.subnet_nsg_associations : key => {
      subnet_id = module.subnet.subnet_ids[association.subnet_key]

      network_security_group_id = module.nsg.network_security_group_ids[association.nsg_key]
    }
  }


  # --------------------------------------------------
  # NIC NSG Associations
  # --------------------------------------------------

  nic_nsg_associations = {
    for key, association in var.nic_nsg_associations : key => {
      network_interface_id = module.nic.network_interface_ids[association.nic_key]

      network_security_group_id = module.nsg.network_security_group_ids[association.nsg_key]
    }
  }


  # --------------------------------------------------
  # Network Interfaces
  # --------------------------------------------------

  network_interfaces = {
    for key, nic in var.network_interfaces : key => {
      name                = nic.name
      resource_group_name = nic.resource_group_name
      location            = nic.location

      subnet_id = module.subnet.subnet_ids[nic.subnet_key]
    }
  }


  # --------------------------------------------------
  # Linux VMs
  # --------------------------------------------------

  linux_vms = {
    for key, vm in var.linux_vms : key => {
      name                = vm.name
      resource_group_name = vm.resource_group_name
      location            = vm.location
      size                = vm.size
      admin_username      = vm.admin_username
      admin_password      = vm.admin_password
      ssh_public_key      = vm.ssh_public_key
      computer_name       = vm.computer_name
      os_disk_size_gb     = vm.os_disk_size_gb

      nic_id = module.nic.network_interface_ids[vm.nic_key]
    }
  }


  # --------------------------------------------------
  # Windows VMs
  # --------------------------------------------------

  windows_vms = {
    for key, vm in var.windows_vms : key => {
      name                = vm.name
      resource_group_name = vm.resource_group_name
      location            = vm.location
      size                = vm.size
      admin_username      = vm.admin_username
      admin_password      = vm.admin_password
      computer_name       = vm.computer_name
      os_disk_size_gb     = vm.os_disk_size_gb

      nic_id = module.nic.network_interface_ids[vm.nic_key]
    }
  }


  # --------------------------------------------------
  # SQL Servers
  # --------------------------------------------------

  sql_servers = {
    for key, server in var.sql_servers : key => {
      name                = server.name
      resource_group_name = server.resource_group_name
      location            = server.location
      version             = server.version

      administrator_login          = server.administrator_login
      administrator_login_password = var.sql_admin_password
    }
  }


  # --------------------------------------------------
  # SQL Databases
  # --------------------------------------------------

  sql_databases = {
    for key, database in var.sql_databases : key => {
      name           = database.name
      sku_name       = database.sku_name
      max_size_gb    = database.max_size_gb
      zone_redundant = database.zone_redundant

      server_id = module.sql_server.sql_server_ids[database.server_key]
    }
  }
}