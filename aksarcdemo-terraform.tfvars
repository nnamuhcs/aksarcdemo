aks_clusters = [
 # Add configurations for remaining clusters
  {
    name                      = "cluster1"
    resource_group_name       = "rg-cluster1"
    custom_location_name      = "custom-location1"
    logical_network_name      = "logical-network1"
    keyvault_name             = "kv-cluster1"
    agent_pool_profiles       = {...} # specify profile details
    control_plane_ip          = "10.0.0.1"
    control_plane_count       = 3
    rbac_admin_group_object_ids = ["group-id-1"]
  },
  {
    name                      = "cluster2"
    resource_group_name       = "rg-cluster2"
    custom_location_name      = "custom-location2"
    logical_network_name      = "logical-network2"
    keyvault_name             = "kv-cluster2"
    agent_pool_profiles       = {...}
    control_plane_ip          = "10.0.0.2"
    control_plane_count       = 3
    rbac_admin_group_object_ids = ["group-id-2"]
  },
  {
    name                      = "cluster3"
    resource_group_name       = "rg-cluster3"
    custom_location_name      = "custom-location3"
    logical_network_name      = "logical-network3"
    keyvault_name             = "kv-cluster3"
    agent_pool_profiles       = {...} # specify profile details
    control_plane_ip          = "10.0.0.1"
    control_plane_count       = 3
    rbac_admin_group_object_ids = ["group-id-3"]
  },
  {
    name                      = "cluster4"
    resource_group_name       = "rg-cluster4"
    custom_location_name      = "custom-location4"
    logical_network_name      = "logical-network4"
    keyvault_name             = "kv-cluster4"
    agent_pool_profiles       = {...}
    control_plane_ip          = "10.0.0.2"
    control_plane_count       = 3
    rbac_admin_group_object_ids = ["group-id-4"]
  },
  {
    name                      = "cluster5"
    resource_group_name       = "rg-cluster5"
    custom_location_name      = "custom-location5"
    logical_network_name      = "logical-network5"
    keyvault_name             = "kv-cluster5"
    agent_pool_profiles       = {...}
    control_plane_ip          = "10.0.0.2"
    control_plane_count       = 3
    rbac_admin_group_object_ids = ["group-id-5"]
  },
]
