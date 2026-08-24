module "rg" {
  source = "./modules/network/rg"

  resource_groups = var.resource_groups
}


module "vnet" {
  source = "./modules/network/vnet"

  virtual_networks = var.virtual_networks

  depends_on = [
    module.rg
  ]
}


module "subnet" {
  source = "./modules/network/subnet"

  subnets = var.subnets

  depends_on = [
    module.vnet
  ]
}


module "pip" {
  source = "./modules/network/pip"

  public_ips = var.public_ips

  depends_on = [
    module.rg
  ]
}


module "bastion" {
  source = "./modules/network/bastion"

  bastions = local.bastions

  depends_on = [
    module.subnet,
    module.pip
  ]
}


module "nsg" {
  source = "./modules/network/nsg"

  network_security_groups = var.network_security_groups

  depends_on = [
    module.rg
  ]
}


module "nsg_association" {
  source = "./modules/network/nsg_association"

  subnet_nsg_associations = local.subnet_nsg_associations
  nic_nsg_associations    = local.nic_nsg_associations

  depends_on = [
    module.subnet,
    module.nsg,
    module.nic
  ]
}


module "nic" {
  source = "./modules/compute/nic"

  network_interfaces = local.network_interfaces

  depends_on = [
    module.subnet
  ]
}


module "vm" {
  source = "./modules/compute/vm"

  linux_vms   = local.linux_vms
  windows_vms = local.windows_vms

  depends_on = [
    module.nic
  ]
}


module "sql_server" {
  source = "./modules/database/sql_server"

  sql_servers = local.sql_servers

  depends_on = [
    module.rg
  ]
}


module "sql_database" {
  source = "./modules/database/sql_database"

  sql_databases = local.sql_databases

  depends_on = [
    module.sql_server
  ]
}