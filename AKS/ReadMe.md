# First Import below three Existing Resources and then fire Terraform Plan command #

# 1. Import existing ResourceGroup
terraform import azurerm_resource_group.aks_rg /subscriptions/aba5e784-1c6c-445f-95bd-16bd462e5603/resourceGroups/RG_PREMI0012345_WEU

# 2. Import existing Virtual Network
terraform import azurerm_virtual_network.aks_vnet /subscriptions/aba5e784-1c6c-445f-95bd-16bd462e5603/resourceGroups/RG_PREMI0012345_WEU/providers/Microsoft.Network/virtualNetworks/VNET-PREMI0012345-WEU

# 3. Import existing Subnet
terraform import azurerm_subnet.aks_subnet /subscriptions/aba5e784-1c6c-445f-95bd-16bd462e5603/resourceGroups/RG_PREMI0012345_WEU/providers/Microsoft.Network/virtualNetworks/VNET-PREMI0012345-WEU/subnets/VNET-PREMI0012345-Subnet-AKS


# Access Kubernetes Cluster using kubectl
az account set --subscription aba5e784-1c6c-445f-95bd-16bd462e5603

az aks get-credentials --resource-group RG_PREMI0012345_WEU --name s2aksdemocluster

kubectl get nodes -o wide