# You can write your azure powershell scripts inline here.
# You can also pass predefined and custom variables to this script using arguments
#
# $resourceGroup="test-kv-or-rg"
#
param ($resourceGroupName, $keyVaultName, $templateFile)
write-host "named parameter -> resourceGroup: $resourceGroupName, keyVaultName: $keyVaultName";
$vms = (Get-AzVM -ResourceGroupName "$resourceGroupName" | select name |  ft -HideTableHeaders | Out-String).TrimStart().Trim();
foreach ($vm in $vms) {
  write-host "processing $vm in $resourceGroup...";
  New-AzResourceGroupDeployment -ResourceGroupName "$resourceGroupName" -TemplateFile "$templateFile" -virtualMachineName $vm -keyVaultName $keyVaultName
};
