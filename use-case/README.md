# Use Case: Deploying Terraform to Azure

## Steps

1. Deploy Shared IaC
```powershell
terraform apply -var-file="tfvars/shared.tfvars"
```

2. Upload Container Image to ACR
```powershell
az acr login --name crpoabdemone
docker push crpoabdemone.azurecr.io/backend:latest
```

3. Deploy Environment IaC
```powershell
terraform apply -var-file="tfvars/dev.tfvars"
```