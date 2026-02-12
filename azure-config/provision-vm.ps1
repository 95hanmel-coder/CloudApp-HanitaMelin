# Azure VM Provisioning Script
# This script provisions an Ubuntu VM for hosting a .NET application

# Variables
$resourceGroup = "CloudApp-RG"
$location = "swedencentral"
$vmName = "CloudAppVM"
$adminUsername = "azureuser"
$vmSize = "Standard_B1s"

# Create resource group
Write-Host "Creating resource group..." -ForegroundColor Green
az group create --name $resourceGroup --location $location

# Create VM with SSH key authentication
Write-Host "Creating Ubuntu VM..." -ForegroundColor Green
az vm create `
  --resource-group $resourceGroup `
  --name $vmName `
  --image Ubuntu2204 `
  --size $vmSize `
  --admin-username $adminUsername `
  --generate-ssh-keys `
  --public-ip-sku Standard

# Open port 80 for HTTP traffic
Write-Host "Opening port 80..." -ForegroundColor Green
az vm open-port --port 80 --resource-group $resourceGroup --name $vmName --priority 1001

# Open port 5000 for .NET application
Write-Host "Opening port 5000..." -ForegroundColor Green
az vm open-port --port 5000 --resource-group $resourceGroup --name $vmName --priority 1002

# Get public IP
Write-Host "Getting VM public IP..." -ForegroundColor Green
$publicIP = az vm show -d --resource-group $resourceGroup --name $vmName --query publicIps -o tsv

Write-Host "`nVM created successfully!" -ForegroundColor Green
Write-Host "Public IP: $publicIP" -ForegroundColor Yellow
Write-Host "SSH command: ssh $adminUsername@$publicIP" -ForegroundColor Yellow