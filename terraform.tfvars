resource_groups = {
  main = {
    name     = "rg-3tier-dev"
    location = "Central India"
  }
  main1 = {
    name     = "rg-3tier-dev1"
    location = "Central India"
  }
}


virtual_networks = {
  main = {
    name                = "vnet-3tier-dev"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"
    address_space       = ["10.0.0.0/16"]
  }
}


subnets = {
  web = {
    name                 = "snet-3tier-web"
    resource_group_name  = "rg-3tier-dev"
    virtual_network_name = "vnet-3tier-dev"
    address_prefixes     = ["10.0.1.0/24"]
  }

  app = {
    name                 = "snet-3tier-app"
    resource_group_name  = "rg-3tier-dev"
    virtual_network_name = "vnet-3tier-dev"
    address_prefixes     = ["10.0.2.0/24"]
  }

  db = {
    name                 = "snet-3tier-db"
    resource_group_name  = "rg-3tier-dev"
    virtual_network_name = "vnet-3tier-dev"
    address_prefixes     = ["10.0.3.0/24"]
  }

  bastion = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-3tier-dev"
    virtual_network_name = "vnet-3tier-dev"
    address_prefixes     = ["10.0.4.0/26"]
  }
}


public_ips = {
  bastion = {
    name                = "pip-3tier-bastion"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}


bastions = {
  main = {
    name                = "bas-3tier-dev"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"
    sku                 = "Standard"

    subnet_key    = "bastion"
    public_ip_key = "bastion"
  }
}


network_security_groups = {
  web = {
    name                = "nsg-3tier-web"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"

    security_rules = {
      http = {
        name                       = "allow-http"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Allow HTTP traffic"
      }

      https = {
        name                       = "allow-https"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Allow HTTPS traffic"
      }
    }
  }

  app = {
    name                = "nsg-3tier-app"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"

    security_rules = {
      web_to_app = {
        name                       = "allow-web-to-app"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "10.0.1.0/24"
        destination_address_prefix = "*"
        description                = "Allow Web tier to App tier"
      }
    }
  }

  db = {
    name                = "nsg-3tier-db"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"

    security_rules = {
      app_to_sql = {
        name                       = "allow-app-to-sql"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "1433"
        source_address_prefix      = "10.0.2.0/24"
        destination_address_prefix = "*"
        description                = "Allow App tier to SQL"
      }
    }
  }
}


subnet_nsg_associations = {
  web = {
    subnet_key = "web"
    nsg_key    = "web"
  }

  app = {
    subnet_key = "app"
    nsg_key    = "app"
  }

  db = {
    subnet_key = "db"
    nsg_key    = "db"
  }
}


nic_nsg_associations = {}


network_interfaces = {
  web = {
    name                = "nic-3tier-web-01"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"
    subnet_key          = "web"
  }

  app = {
    name                = "nic-3tier-app-01"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"
    subnet_key          = "app"
  }
}


linux_vms = {
  web = {
    name                = "vm-3tier-web-01"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"
    size                = "Standard_B2s"
    admin_username      = "azureadmin"
    nic_key             = "web"
    computer_name       = "web01"
    os_disk_size_gb     = 30
  }

  app = {
    name                = "vm-3tier-app-01"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"
    size                = "Standard_B2s"
    admin_username      = "azureadmin"
    nic_key             = "app"
    computer_name       = "app01"
    os_disk_size_gb     = 30
  }
}


windows_vms = {}


sql_servers = {
  primary = {
    name                = "sql-3tier-dev"
    resource_group_name = "rg-3tier-dev"
    location            = "Central India"
    administrator_login = "sqladmin"
    version             = "12.0"
  }
}


sql_databases = {
  application = {
    name           = "sqldb-3tier-app"
    server_key     = "primary"
    sku_name       = "S0"
    max_size_gb    = 32
    zone_redundant = false
  }
}