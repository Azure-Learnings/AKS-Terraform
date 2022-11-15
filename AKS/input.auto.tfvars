# Replace the value as per your Subscription details #
resource_group  = "RG_PREMI0012345_WEU"
aks_vnet_name   = "VNET-PREMI0012345-WEU"
vnetcidr        = ["172.16.0.0/16"]
aks_subnet_name = "VNET-PREMI0012345-Subnet-AKS"
subnetcidr      = ["172.16.16.0/20"]
keyvault_rg     = "RG_PREMI0012345_WEU"
keyvault_name   = "S2-PREMI0012345-KV"
azure_region    = "westeurope"
cluster_name    = "s2aksdemocluster"
sshkvsecret     = "s2sshpubkey"
clientidkvsecret = "aks-spn-id"
spnkvsecret     = "aks-spn-secret"
dns_name        = "s2aksdemocluster"
admin_username  = "aksadmin"
kubernetes_version = "1.23.12"
agent_pools = {
    name            = "s2pool1"
    count           = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = "30"
}