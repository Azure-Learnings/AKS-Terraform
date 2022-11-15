#### Parameters

$keyvaultname = "S2-PREMI0012345-KV"
$location = "westeurope"
$keyvaultrg = "RG_PREMI0012345_WEU"
$sshkeyname = "s2sshpubkey"
$spnclientid = "97cfcee3-669f-4bba-8a48-6426f3b72b4d"
$clientidkvsecretname = "aks-spn-id"
$spnclientsecret = "08-8Q~FUYjKFuwXcXqUYkfeXXIe52FV667aU_dov"
$spnkvsecretname = "aks-spn-secret"
$spobjectID = "5e99f174-75e6-4815-9a9a-c528b18fd63d"
$userobjectid = "1ec528a3-e76a-48f5-b37b-c1d6e2c5c744"


#### Create Key Vault
New-AzResourceGroup -Name $keyvaultrg -Location $location
New-AzKeyVault -Name $keyvaultname -ResourceGroupName $keyvaultrg -Location $location
Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -ObjectID $userobjectid -PermissionsToSecrets Get,Set,Delete,List

## Create Key Vault with AZ CLI
# az create --resource-group --name $keyvaultrg --location $location
# az keyvault create --name $keyvaultname --resource-group $keyvaultrg --location $location
# az keyvault set-policy --name "S2-PREMI0012345-KV" --object-id 1ec528a3-e76a-48f5-b37b-c1d6e2c5c744 --secret-permissions get, set, delete, list

#### create an ssh key for setting up password-less login between agent nodes.
ssh-keygen  -f ~/.ssh/id_rsa_terraform

#### Add SSH Key in Azure Key vault secret
$pubkey = cat ~/.ssh/id_rsa_terraform.pub
$Secret = ConvertTo-SecureString -String $pubkey -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $sshkeyname -SecretValue $Secret

#### Store service principal Client id in Azure KeyVault
$Secret = ConvertTo-SecureString -String $spnclientid -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $clientidkvsecretname -SecretValue $Secret

#### Store service principal Secret in Azure KeyVault
$Secret = ConvertTo-SecureString -String $spnclientsecret -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $spnkvsecretname -SecretValue $Secret

#### Provide Keyvault secret access to SPN using Keyvault access policy
Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -ObjectID $spobjectID -PermissionsToSecrets Get,Set,list