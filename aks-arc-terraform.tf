terraform {
  required_version = "~> 1.5"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.13"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Define a variable to store the cluster configurations
variable "aks_clusters" {
  type = list(object({
    name                      = string
    resource_group_name       = string
    custom_location_name      = string
    logical_network_name      = string
    keyvault_name             = string
    agent_pool_profiles       = map(any) # customize as per your pool profile structure
    control_plane_ip          = string
    control_plane_count       = number
    rbac_admin_group_object_ids = list(string)
  }))
}

# Loop through each cluster configuration to deploy multiple clusters
resource "azurerm_resource_group" "rg" {
  for_each = { for cluster in var.aks_clusters : cluster.name => cluster }
  name     = each.value.resource_group_name
  location = var.default_location
}

data "azapi_resource" "customlocation" {
  for_each  = azurerm_resource_group.rg
  type      = "Microsoft.ExtendedLocation/customLocations@2021-08-15"
  name      = each.value.custom_location_name
  parent_id = each.value.id
}

data "azapi_resource" "logical_network" {
  for_each  = azurerm_resource_group.rg
  type      = "Microsoft.AzureStackHCI/logicalNetworks@2023-09-01-preview"
  name      = each.value.logical_network_name
  parent_id = each.value.id
}

data "azurerm_key_vault" "deployment_key_vault" {
  for_each            = azurerm_resource_group.rg
  name                = each.value.keyvault_name
  resource_group_name = each.value.resource_group_name
}

# Module to create each AKS Arc cluster with unique configurations
module "aks_arc_cluster" {
  for_each = azurerm_resource_group.rg

  source                = "../../"
  location              = each.value.location
  name                  = each.key
  resource_group_id     = each.value.id

  enable_telemetry      = var.enable_telemetry
  custom_location_id    = data.azapi_resource.customlocation[each.key].id
  logical_network_id    = data.azapi_resource.logical_network[each.key].id
  agent_pool_profiles   = each.value.agent_pool_profiles
  ssh_key_vault_id      = data.azurerm_key_vault.deployment_key_vault[each.key].id
  control_plane_ip      = each.value.control_plane_ip
  control_plane_count   = each.value.control_plane_count
  rbac_admin_group_object_ids = each.value.rbac_admin_group_object_ids
}
