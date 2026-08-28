module "rg" {
  source = "./modules/network/rg"

  resource_groups = var.resource_groups
}

